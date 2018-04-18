//
//  ViewController.m
//  OpenGL ES One
//
//  Created by caopengxu on 2018/4/17.
//  Copyright © 2018年 caopengxu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) EAGLContext *mContext;
@property (nonatomic, strong) GLKBaseEffect *mEffect;
@property(nonatomic, weak) GLKView *mView;
@end


@implementation ViewController

- (GLKView *)mView
{
    return (GLKView *)self.view;
}


#pragma mark === viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    [self setupVertex];
    [self setupTexCoord];
}


- (void)setup
{
    _mContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3];
    [EAGLContext setCurrentContext:_mContext];
    self.mView.context = _mContext;
    
    _mEffect = [[GLKBaseEffect alloc] init];
}


- (void)setupVertex
{
    GLfloat vertexData[] =
    {
        -0.5, 0.5, 0.0f, 1.0f, // 左上
        0.5, 0.5, 1.0f, 1.0f, // 右上
        0.5, -0.5, 1.0f, 0.0f, // 右下
        -0.5, -0.5, 0, 0, // 左下
    };
    
    GLuint VBO[] = {
        0,1,2,
        0,3,2
    };
    
    GLuint buffer;
    glGenBuffers(1, &buffer);
    glBindBuffer(GL_ARRAY_BUFFER, buffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertexData), vertexData, GL_STATIC_DRAW);
    
    GLuint EBO;
    glGenBuffers(1, &EBO);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(VBO), VBO, GL_STATIC_DRAW);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 2, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 4, (GLfloat*)NULL + 0);
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(GLfloat) * 4, (GLfloat*)NULL + 2);
}


- (void)setupTexCoord
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"flag" ofType:@"png"];
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:@(1), GLKTextureLoaderOriginBottomLeft, nil];
    GLKTextureInfo *info = [GLKTextureLoader textureWithContentsOfFile:path options:options error:nil];
    self.mEffect.texture2d0.enabled = GL_TRUE;
    self.mEffect.texture2d0.name = info.name;
}


- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    
    [self.mEffect prepareToDraw];
    //    glDrawArrays(GL_TRIANGLES, 0, 6);
    glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, 0);
}

@end


