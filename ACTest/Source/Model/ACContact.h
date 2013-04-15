//
// Created by Chris Hatton on 05/04/2013.
//

#import <Foundation/Foundation.h>

typedef enum MTContactGender
{
	MTContactGenderMale,
	MTContactGenderFemale
}
MTContactGender;

MTContactGender MTContactGenderFromString( NSString* genderString );

@interface ACContact : NSObject

@property (nonatomic,strong)   NSString*       firstName;
@property (nonatomic,strong)   NSString*       lastName;
@property (nonatomic,assign)   NSUInteger      age;
@property (nonatomic,assign)   MTContactGender sex;
@property (nonatomic,strong)   NSURL*          photoUrl;
@property (nonatomic,strong)   UIImage*        photo;
@property (nonatomic,strong)   NSString*       notes;

-(NSString*)fullName;
-(NSString*)genderString;

@end