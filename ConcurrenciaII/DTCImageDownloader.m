//
//  DTCImageDownloader.m
//  ConcurrenciaII
//
//  Created by David de Tena on 08/04/15.
//  Copyright (c) 2015 David de Tena. All rights reserved.
//

#import "DTCImageDownloader.h"
#import "DTCImageViewController.h"

@interface DTCImageDownloader()

@property (strong,nonatomic) DTCImageViewController *imageVC;

@end

@implementation DTCImageDownloader

#pragma mark - Init
-(id) initWithImageViewController:(DTCImageViewController *) vc{
    if (self = [super init]) {
        self.imageVC = vc;
    }
    return self;
}


#pragma mark - Main

// Sobreescribimos método main, que será el que tiene las tareas a realizar en segundo plano
-(void) main{

    NSURL *url = [NSURL URLWithString:@"http://media.vandal.net/master/14199/20121210152529_3.jpg"];
    NSData *imgData = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:imgData];
    
    // NECESITAMOS ACTUALIZAR LA INTERFAZ EN PRIMER PLANO, por lo que llamamos a este
    // método, que necesita un @selector que contenga las operaciones a realizar (definido abajo)
    [self performSelectorOnMainThread:@selector(updateViewControllerWithImage:)
                           withObject:image
                        waitUntilDone:NO];
}


-(void) updateViewControllerWithImage: (UIImage *) image{
    // Esto se realizará en primer plano => actualizar la interfaz
    self.imageVC.imageView.image = image;
    [self.imageVC.activityView stopAnimating];
}

@end
