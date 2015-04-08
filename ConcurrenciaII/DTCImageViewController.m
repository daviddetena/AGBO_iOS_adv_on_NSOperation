//
//  DTCImageViewController.m
//  ConcurrenciaII
//
//  Created by David de Tena on 08/04/15.
//  Copyright (c) 2015 David de Tena. All rights reserved.
//
//  Descargaremos una imagen pesada y le aplicaremos un filtro, para ver cómo funciona NSOperation
//  y generar dependencias entre las dos operaciones.

#import "DTCImageViewController.h"
#import "DTCImageDownloader.h"
#import "DTCImageFilter.h"

@interface DTCImageViewController ()

// Propiedad para guardar la cola
@property (nonatomic,strong) NSOperationQueue *queue;

@end

@implementation DTCImageViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _queue = [[NSOperationQueue alloc] init];
    }
    return self;
}

- (IBAction)downloadImage:(id)sender {
    
    // Preparar la interfaz para el segundo plano (activity view)
    [self.activityView startAnimating];
        
    // Crear las operaciones
    DTCImageDownloader *downloaderOp = [[DTCImageDownloader alloc] initWithImageViewController:self];
    DTCImageFilter *filterOp = [[DTCImageFilter alloc] initWithImageViewController:self];
    
    // Enlazar las operaciones creando dependencias
    // El filtro depende de downloader, por lo que no se ejecutará hasta que no se descargue la imagen
    [filterOp addDependency:downloaderOp];
    
    
    // Mandar las operaciones a la cola
    [self.queue addOperation:downloaderOp];
    [self.queue addOperation:filterOp];
    
}
@end
