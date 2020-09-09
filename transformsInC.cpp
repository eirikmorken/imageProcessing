#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/highgui/highgui.hpp"
#include <stdlib.h>
#include <iostream>
#include <stdio.h>

using namespace std;
using namespace cv;

/// Global variables

Mat src, src_gray;
Mat dst, detected_edges;

char* window_name0 = "Original Image";
char* window_name1 = "Grayscale Image";
char* window_name2 = "Image After Histogram Equalization";
char* remap_window1 = "Remap - upside down";
char* remap_window2 = "Remap - reflection in the x direction";
char* window_name4 = "Median Filtered Image";
char* window_name5 = "Gaussian Filtered Image";

int ddepth = CV_16S;
int scale = 1;
int delta = 0;
int kernel_size = 3;
char* window_name6 = "Laplace Demo";

char* window_name7 = "Sobel Demo - Simple Edge Detector";

/// Global Variables
int MAX_KERNEL_LENGTH = 6;


/** @function main */
int main( int argc, char** argv )
{

    if( argc != 2)
    {
     cout <<" Usage: display_image ImageToLoadAndDisplay" << endl;
     return -1;
    }
	src = imread(argv[1]);

	namedWindow(window_name0, CV_WINDOW_AUTOSIZE);
	imshow(window_name0, src);

	// Call the appropriate function in OPENCV to load the image
		
	if( !src.data )
	{ return -1; }

	// Create a window called "Original Image" and show original image

	
	// Call the appropriate function in OPENCV to convert the image to grayscale
	cvtColor(src, src_gray, CV_BGR2GRAY);


	// Create a window called "Grayscale Image" and show grayscale image
	namedWindow(window_name1, CV_WINDOW_AUTOSIZE);
	imshow(window_name1, src_gray);

	// Apply histogram equalization to the grayscale image
	Mat equalizedHistogram;
	equalizeHist(src_gray, dst);
	equalizeHist(src_gray, equalizedHistogram);
	
	// Create a window called "Image After Histogram Equalization" and show the image after histogram equalization
	namedWindow(window_name2, CV_WINDOW_AUTOSIZE);
	imshow(window_name2, dst);

	// Apply remapping; first turn the image upside down and then reflect the image in the x direction
	
    // For this part, the upside down image and the flipped left image are created as the Mat variables "image_upsidedown" and "image_flippedleft". Also, map_x and map_y are created with the same size as equalized_image:
		Mat image_upsidedown;
		Mat image_flippedleft;
		image_upsidedown.create(dst.size(), dst.type());
		
		Mat map_x, map_y;

	// Apply upside down operation to the image for which histogram equalization is applied.
		map_x.create(dst.size(), CV_32FC1);
		map_y.create(dst.size(), CV_32FC1);
		for (int i = 0; i < dst.rows; i++) {
			for (int j = 0; j < dst.cols; j++) {
				map_x.at<float>(i, j) = j;
				map_y.at<float>(i, j) = dst.cols - i;
			}
		}
		remap(dst, image_upsidedown, map_x, map_y, CV_INTER_LINEAR, BORDER_CONSTANT, Scalar(0,0, 0));

	// Create a window called "Remap - upside down" and show the image after applying remapping - upside down
		namedWindow(remap_window1, CV_WINDOW_AUTOSIZE);
		imshow(remap_window1, image_upsidedown);

	// Apply reflection in the x direction operation to the image for which histogram equalization is applied.
		image_flippedleft.create(dst.size(), dst.type());
		map_x.create(dst.size(), CV_32FC1);
		map_y.create(dst.size(), CV_32FC1);
		for (int i = 0; i < dst.rows; i++) {
			for (int j = 0; j < dst.cols; j++) {
				map_x.at<float>(i, j) = dst.rows-j;
				map_y.at<float>(i, j) = i;
			}
		}
		remap(dst, image_flippedleft, map_x, map_y, CV_INTER_LINEAR, BORDER_CONSTANT, Scalar(0, 0, 0));
	
	// Create a window called "Remap - reflection in the x direction" and show the image after applying remapping - reflection in the x direction
		namedWindow(remap_window2, CV_WINDOW_AUTOSIZE);
		imshow(remap_window2, image_flippedleft);

   
	// Apply Median Filter to the Image for which histogram equalization is applied 
		Mat image_median;
		medianBlur(dst, image_median, 5);

	// Create a window called "Median Filtered Image" and show the image after applying median filtering

		namedWindow(window_name4, CV_WINDOW_AUTOSIZE);
		imshow(window_name4, image_median);
	
    // Remove noise from the image for which histogram equalization is applied by blurring with a Gaussian filter
		Mat image_gaus;
		GaussianBlur(dst, image_gaus, Size(3, 3), 0, 0);


	// Create a window called "Gaussian Filtered Image" and show the image after applying Gaussian filtering
		namedWindow(window_name5, CV_WINDOW_AUTOSIZE);
		imshow(window_name5, image_gaus);

	/// Apply Laplace function to compute the edge image using the Laplace Operator
		Mat image_laplace;
		Laplacian(image_gaus, dst, CV_16S, 3, 1, 0); //kernel_size = 3, scale = 1, delta = 0.
		convertScaleAbs(dst, image_laplace);

    /// Create window called "Laplace Demo" and show the edge image after applying Laplace Operator
		namedWindow(window_name6, CV_WINDOW_AUTOSIZE);
		imshow(window_name6, image_laplace);


	// Apply Sobel Edge Detection
	/// Appropriate variables grad, grad_x and grad_y, abs_grad_x and abs_grad_y are generated
	Mat grad;
	Mat grad_x, grad_y;
	Mat abs_grad_x, abs_grad_y;

	/// Compute Gradient X
	Sobel(image_gaus, grad_x, CV_16S, 1, 0, 3, 1, 0);

	/// Compute Gradient Y
	Sobel(image_gaus, grad_y, CV_16S, 0, 1, 3, 1, 0);

	/// Compute Total Gradient (approximate)
	convertScaleAbs(grad_x, abs_grad_x);
	convertScaleAbs(grad_y, abs_grad_y);
	addWeighted(abs_grad_x, 0.5, abs_grad_y, 0.5, 0, grad);
	/// Create window called "Sobel Demo - Simple Edge Detector" and show Sobel edge detected image
	namedWindow(window_name7, CV_WINDOW_AUTOSIZE);
	imshow(window_name7, grad);

	//Saving all images on desktop.
	/*imwrite("//homes.eurecom.fr/morken/Windesktop/Improc/OrignalImage.jpg", src);
	imwrite("//homes.eurecom.fr/morken/Windesktop/Improc/Grayscale.jpg", src_gray);
	imwrite("//homes.eurecom.fr/morken/Windesktop/Improc/HistogramEqualization.jpg", equalizedHistogram);
	imwrite("//homes.eurecom.fr/morken/Windesktop/Improc/Upsidedown.jpg", image_upsidedown);
	imwrite("//homes.eurecom.fr/morken/Windesktop/Improc/ImageFlippedleft.jpg", image_flippedleft);
	imwrite("//homes.eurecom.fr/morken/Windesktop/Improc/MedianBlur.jpg", image_median);
	imwrite("//homes.eurecom.fr/morken/Windesktop/Improc/Gaussian.jpg", image_gaus);
	imwrite("//homes.eurecom.fr/morken/Windesktop/Improc/Laplacian.jpg", image_laplace);
	imwrite("//homes.eurecom.fr/morken/Windesktop/Improc/Sobel.jpg", grad);
	*/

  /// Wait until user exit program by pressing a key
  waitKey(0);

  return 0;
  }