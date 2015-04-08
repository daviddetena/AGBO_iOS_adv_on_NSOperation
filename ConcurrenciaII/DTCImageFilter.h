//
//  DTCImageFilter.h
//  ConcurrenciaII
//
//  Created by David de Tena on 08/04/15.
//  Copyright (c) 2015 David de Tena. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DTCImageViewController;


@interface DTCImageFilter : NSOperation


-(id) initWithImageViewController: (DTCImageViewController *)vc;

@end
