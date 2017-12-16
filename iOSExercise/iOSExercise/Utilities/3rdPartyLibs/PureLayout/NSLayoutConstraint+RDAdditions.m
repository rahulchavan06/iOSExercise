//
//  NSLayoutConstraint+RDAdditions.m
//  ConstraintCategoryForMovingOnRotation
//
//  Created by Eric G. DelMar on 11/20/13.
//  Copyright (c) 2013 Eric G. DelMar. All rights reserved.
//

#import "NSLayoutConstraint+RDAdditions.h"

@implementation NSLayoutConstraint (RDAdditions)


+(NSLayoutConstraint *)heightConstraintForView:(UIView *)subview superview:(UIView *)superview portraitValue:(CGFloat)pValue landscapeValue:(CGFloat)lValue {
    CGFloat multiplier = (pValue - lValue)/(superview.bounds.size.height - superview.bounds.size.width);
    CGFloat constant = pValue - (superview.bounds.size.height * multiplier);
    NSLayoutConstraint *con = [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeHeight relatedBy:0 toItem:superview attribute:NSLayoutAttributeHeight multiplier:multiplier constant:constant];
    NSLog(@"height coeffs: %f   %f",multiplier,constant);
    return con;
}

+(NSLayoutConstraint *)widthConstraintForView:(UIView *)subview superview:(UIView *)superview portraitValue:(CGFloat)pValue landscapeValue:(CGFloat)lValue {
    CGFloat multiplier = (pValue - lValue)/(superview.bounds.size.width - superview.bounds.size.height);
    CGFloat constant = pValue - (superview.bounds.size.width * multiplier);
    NSLayoutConstraint *con = [NSLayoutConstraint constraintWithItem:subview attribute:NSLayoutAttributeWidth relatedBy:0 toItem:superview attribute:NSLayoutAttributeWidth multiplier:multiplier constant:constant];
    NSLog(@"width coeffs: %f   %f",multiplier,constant);
    return con;
}


+(NSLayoutConstraint *)leftConstraintForView:(UIView *)subview viewAttribute:(NSLayoutAttribute) att superview:(UIView *)superview portraitValue:(CGFloat)pValue landscapeValue:(CGFloat)lValue {
    CGFloat multiplier = (pValue - lValue)/(superview.bounds.size.width - superview.bounds.size.height);
  
    CGFloat constant = pValue - (superview.bounds.size.width * multiplier);
    NSLayoutConstraint *con = [NSLayoutConstraint constraintWithItem:subview attribute:att relatedBy:0 toItem:superview attribute:NSLayoutAttributeRight multiplier:multiplier constant:constant];
    NSLog(@"left coeffs: %f   %f",multiplier,constant);
    return con;
}


+(NSLayoutConstraint *)rightConstraintForView:(UIView *)subview viewAttribute:(NSLayoutAttribute) att superview:(UIView *)superview portraitValue:(CGFloat)pValue landscapeValue:(CGFloat)lValue {
    CGFloat multiplier = (superview.bounds.size.width - pValue - superview.bounds.size.height + lValue)/(superview.bounds.size.width - superview.bounds.size.height);
    CGFloat constant = superview.bounds.size.width - pValue - (superview.bounds.size.width * multiplier);
    NSLayoutConstraint *con = [NSLayoutConstraint constraintWithItem:subview attribute:att relatedBy:0 toItem:superview attribute:NSLayoutAttributeRight multiplier:multiplier constant:constant];
     NSLog(@"right coeffs: %f   %f",multiplier,constant);
    return con;
}

+(NSLayoutConstraint *)topConstraintForView:(UIView *)subview viewAttribute:(NSLayoutAttribute) att superview:(UIView *)superview portraitValue:(CGFloat)pValue landscapeValue:(CGFloat)lValue {
    CGFloat multiplier = (pValue - lValue)/(superview.bounds.size.height - superview.bounds.size.width);
    CGFloat constant = pValue - (superview.bounds.size.height * multiplier);
    NSLayoutConstraint *con = [NSLayoutConstraint constraintWithItem:subview attribute:att relatedBy:0 toItem:superview attribute:NSLayoutAttributeBottom multiplier:multiplier constant:constant];
     NSLog(@"top coeffs: %f   %f",multiplier,constant);
    return con;
}


+(NSLayoutConstraint *)bottomConstraintForView:(UIView *)subview viewAttribute:(NSLayoutAttribute) att superview:(UIView *)superview portraitValue:(CGFloat)pValue landscapeValue:(CGFloat)lValue {
    CGFloat multiplier = (superview.bounds.size.height - pValue - superview.bounds.size.width + lValue)/(superview.bounds.size.height - superview.bounds.size.width);
    CGFloat constant = superview.bounds.size.height - pValue - (superview.bounds.size.height * multiplier);
    NSLayoutConstraint *con = [NSLayoutConstraint constraintWithItem:subview attribute:att relatedBy:0 toItem:superview attribute:NSLayoutAttributeBottom multiplier:multiplier constant:constant];
     NSLog(@"bottom coeffs: %f   %f",multiplier,constant);
    return con;
}

@end
