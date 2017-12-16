//
//  NSLayoutConstraint+RDAdditions.h
//  ConstraintCategoryForMovingOnRotation
//
//  Created by Eric G. DelMar on 11/20/13.
//  Copyright (c) 2013 Eric G. DelMar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSLayoutConstraint (RDAdditions)

+(NSLayoutConstraint *)heightConstraintForView:(UIView *)subview superview:(UIView *)superview portraitValue:(CGFloat)pValue landscapeValue:(CGFloat)lValue;
+(NSLayoutConstraint *)widthConstraintForView:(UIView *)subview superview:(UIView *)superview portraitValue:(CGFloat)pValue landscapeValue:(CGFloat)lValue;
+(NSLayoutConstraint *)leftConstraintForView:(UIView *)subview viewAttribute:(NSLayoutAttribute) att superview:(UIView *)superview portraitValue:(CGFloat)pValue landscapeValue:(CGFloat)lValue;
+(NSLayoutConstraint *)rightConstraintForView:(UIView *)subview viewAttribute:(NSLayoutAttribute) att superview:(UIView *)superview portraitValue:(CGFloat)pValue landscapeValue:(CGFloat)lValue;
+(NSLayoutConstraint *)topConstraintForView:(UIView *)subview viewAttribute:(NSLayoutAttribute) att superview:(UIView *)superview portraitValue:(CGFloat)pValue landscapeValue:(CGFloat)lValue;
+(NSLayoutConstraint *)bottomConstraintForView:(UIView *)subview viewAttribute:(NSLayoutAttribute) att superview:(UIView *)superview portraitValue:(CGFloat)pValue landscapeValue:(CGFloat)lValue;


@end
