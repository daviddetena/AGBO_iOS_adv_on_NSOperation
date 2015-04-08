This project shows how to use NSOperation and NSOperationQueue for concurrency w/o using blocks.

1. Create classes for two operations that will include code to be executed in background (in main method): I) Download an image. II) Apply a filter to it.
2. Create dependencies between these two operations: the filter won't be applied until the image is downloaded.
3. Add the operations to NSOperationQueue that will manage them.