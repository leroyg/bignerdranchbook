//
//  QuizAppDelegate.h
//  Quiz
//
//  Created by Tammer Saleh on 12/15/11.
//  Copyright (c) 2011 Thunderbolt Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuizAppDelegate : UIResponder <UIApplicationDelegate> {
    int currentQuestionIndex;
    
    // the models
    NSMutableArray *questions;
    NSMutableArray *answers;
    
    // the views
    IBOutlet UILabel *questionField;
    IBOutlet UILabel *answerField;
}

@property (strong, nonatomic) IBOutlet UIWindow *window;

- (IBAction)showQuestion:(id)sender;
- (IBAction)showAnswer:(id)sender;

@end
