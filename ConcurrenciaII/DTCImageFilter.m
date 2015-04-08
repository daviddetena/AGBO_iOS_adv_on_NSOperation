//
//  DTCImageFilter.m
//  ConcurrenciaII
//
//  Created by David de Tena on 08/04/15.
//  Copyright (c) 2015 David de Tena. All rights reserved.
//

#import "DTCImageFilter.h"
#import "DTCImageViewController.h"
@import CoreImage;


@interface DTCImageFilter()

@property (strong,nonatomic) DTCImageViewController *imageVC;

@end

@implementation DTCImageFilter

-(id) initWithImageViewController: (DTCImageViewController *)vc{
    if (self = [super init]) {
        self.imageVC = vc;
    }
    return self;
}


-(void) updateViewControllerBeforeBackground {
    // Antes de pasar a background animamos activity view
    [self.imageVC.activityView startAnimating];
}

-(void) updateViewControllerAfterBackgroundWithImage: (UIImage *) image{
    // Tras realizar la tarea en segundo plano, paramos activity y mostramos
    // la imagen con el filtro
    [self.imageVC.activityView stopAnimating];
    self.imageVC.imageView.image = image;
}

// Tareas que se ejecutarán en segundo plano (hacer el filtrado de la imagen original)
-(void) main{
    
    // Actualizamos en primer plano
    [self performSelectorOnMainThread:@selector(updateViewControllerBeforeBackground)
                           withObject:nil
                        waitUntilDone:NO];
    
    // PARTE DE CORE IMAGE
    
    // Crear contexto de filtro
    CIContext *context = [CIContext contextWithOptions:nil];
    
    // Crear CIImage con imagen original
    CIImage *image = [CIImage imageWithCGImage:self.imageVC.imageView.image.CGImage];
    
    // Crear filtro de color, asignamos valores por defecto y definimos la de entrada (la original descargada)
    CIFilter *falseColor = [CIFilter filterWithName:@"CIFalseColor"];
    [falseColor setDefaults];
    [falseColor setValue:image forKey:kCIInputImageKey];
    
    // Crear imagen de salida
    CIImage *output = falseColor.outputImage;
    // Generar imagen de salida. El extent es como un CGRect y es lo que necesitamos
    CGImageRef res = [context createCGImage:output fromRect:[output extent]];
    
    
    // Actualizamos en primer plano
    [self performSelectorOnMainThread:@selector(updateViewControllerAfterBackgroundWithImage:)
                           withObject:[UIImage imageWithCGImage:res]
                        waitUntilDone:NO];
    
    // También de CORE IMAGE
    // Liberar la CGImageRef (ARC no sabe liberarlo)
    CGImageRelease(res);
    
}

@end
