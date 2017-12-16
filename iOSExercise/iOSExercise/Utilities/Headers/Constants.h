//
//  Constants.h
//  iOSExercise
//
//  Created by Rahul C on 14/12/17.
//  Copyright © 2017 Rahul C. All rights reserved.
//

//APPLICATION DISPLAY NAME
#define APP_NAME @"iOSExercise"

//APPLICATION BASE URL
#define BASE_URL @"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"

//REQUEST TYPE
#define GET @"GET"

//REQUEST TIMEOUT
#define REQUEST_TIMEOUT_SECONDS 15
#define ERROR_CODE_TIMEOUT      200

//Network constants
#define kContentTypeHeader      @"Content-Type"
#define kContentTypeValue       @"application/json"


//FONT TYPE
#define HELVETICA_NEUE @"HelveticaNeueLTStd-Md"

//FONT SIZE
#define FONT_SIZE_17 17.0f
#define FONT_SIZE_19 19.0f
#define FONT_SIZE_21 21.0F

//TEXT COLOR
#define Dark_Gray_RGB   @"51,51,51"
#define Light_Gray_RGB  @"77,77,77"


typedef enum {
    ServiceSuccess = 1,
    ServiceSuccessNoData,
    ServiceTimeout,
    ServiceFail,
} ServiceStatus;

