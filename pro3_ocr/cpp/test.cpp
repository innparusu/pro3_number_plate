/* header files */
#include <stdio.h>
#include <stdlib.h>
#include <cv.h>
#include <highgui.h>

/* main */
int main(void) {
  IplImage* image;

  /* 静止画像をグレースケールとして読み込む */
  image = cvLoadImage("number.jpg",CV_LOAD_IMAGE_GRAYSCALE);
  if (image == NULL) {
    fprintf(stderr, "読込みに失敗しました.");
    return EXIT_FAILURE;
  }

  /* ウインドウを準備して画像を表示する */
  cvNamedWindow("Grayscale01",CV_WINDOW_AUTOSIZE);
  cvShowImage("Grayscale01",image);

  /* キー入力があるまで待つ */
  cvWaitKey(0); /* これがないと、1瞬だけ表示されて終わる */

  /* メモリを開放する */
  cvReleaseImage(&image);

  /* ウィンドウを破棄する */
  cvDestroyWindow("Grayscale01");

  return EXIT_SUCCESS;
}
