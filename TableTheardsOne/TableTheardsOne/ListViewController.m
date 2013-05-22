//
//  ListViewController.m
//  TableTheardsOne
//
//  Created by nn on 13-5-22.
//  Copyright (c) 2013年 ssn. All rights reserved.
//

#import "ListViewController.h"

@implementation ListViewController

@synthesize photos = _photos;

- (NSDictionary *)photos {
    if (!_photos) {
        NSURL *dataURL = [NSURL URLWithString:kDataURLString];
        _photos = [[NSDictionary alloc] initWithContentsOfURL:dataURL];
    }
    return _photos;
}

- (void)viewDidLoad
{
    self.title = @"photos";
    self.tableView.rowHeight = 80.0;
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setPhotos:nil];
    [super viewDidUnload];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count = self.photos.count;
    return count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCellIdentifier = @"Cell Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSString *rowKey = [[self.photos allKeys] objectAtIndex:indexPath.row];
    NSURL *imageURL = [NSURL URLWithString:[self.photos objectForKey:rowKey]];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *image = nil;
    
    // 9
    if (imageData) {
        UIImage *unfiltered_image = [UIImage imageWithData:imageData];
        image = [self applySepiaFilterToImage:unfiltered_image];
    }
    
    cell.textLabel.text = rowKey;
    cell.imageView.image = image;
    
    return cell;
}
- (UIImage *)applySepiaFilterToImage:(UIImage *)image {
    
    CIImage *inputImage = [CIImage imageWithData:UIImagePNGRepresentation(image)];
    UIImage *sepiaImage = nil;
    CIContext *context = [CIContext contextWithOptions:nil];
    CIFilter *filter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues: kCIInputImageKey, inputImage, @"inputIntensity", [NSNumber numberWithFloat:0.8], nil];
    CIImage *outputImage = [filter outputImage];
    CGImageRef outputImageRef = [context createCGImage:outputImage fromRect:[outputImage extent]];
    sepiaImage = [UIImage imageWithCGImage:outputImageRef];
    CGImageRelease(outputImageRef);
    return sepiaImage;
}
@end
