//
//  DTCImageDownloader.h
//  ConcurrenciaII
//
//  Created by David de Tena on 08/04/15.
//  Copyright (c) 2015 David de Tena. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DTCImageViewController;

@interface DTCImageDownloader : NSOperation

#pragma mark - Init
// Lo ideal sería crear un protocolo que avise mediante métodos antes y después
// de realizar la tarea en segundo plano, en este caso, la descarga de la imagen
// El DTCImageViewController sería el delegado en este caso

-(id) initWithImageViewController:(DTCImageViewController *) vc;

@end
