//
//  JZBasicPicker.m
//  JZKit
//
//  Created by Yan's on 2018/4/27.
//

#import "JZBasicPicker.h"
#import <JZKit/JZGeneralMacros.h>

#pragma mark - JZBasicPickerConfiguration
@implementation JZBasicPickerConfiguration
#pragma mark - 单例
+ (JZBasicPickerConfiguration *)globalConfiguration{
    
    static JZBasicPickerConfiguration *globalConfiguration;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        globalConfiguration = [[JZBasicPickerConfiguration alloc] init];
        
    });
    
    return globalConfiguration;
}
#pragma mark - 初始化
- (instancetype)init{
    
    if (self = [super init]){
        
        self.textFont = FONT_BOLD(UI_SCALE(16));
        self.confirmTextColor = MMHexColor(0x4A4A4AFF);
        self.cancelTextColor = MMHexColor(0x4A4A4AFF);
        self.tintColor = MMHexColor(0xF7F6F5FF);
        self.confirmText = @"确认";
        self.cancelText = @"取消";
        self.separateLineColor = MMHexColor(0xE7E7E7FF);
        self.selectedTextColor = MMHexColor(0x4A4A4AFF);
    }
    
    return self;
}

@end

#pragma mark - JZBasicPicker
@implementation JZBasicPicker
#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.type = MMPopupTypeSheet;
        
        CGFloat margin = UI_IS_IPHONE_X ? 33 : 0;
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(UI_SCREEN_WIDTH);
            make.height.mas_equalTo(UI_SCALE(240)+1 + margin);
        }];
        
        [[MMPopupWindow sharedWindow] setTouchWildToHide:YES];
        
        [self prepareUI];
        
    }
    
    return self;
    
}
#pragma mark - UI
- (void)prepareUI{
    
    //配置信息
    JZBasicPickerConfiguration *globalConfiguration = [JZBasicPickerConfiguration globalConfiguration];
    
    //线
    UIView *lineTop = [self createLine];
    [lineTop mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
    }];
    
    
    //按钮栏
    _bar = [[UIView alloc] init];
    _bar.backgroundColor = globalConfiguration.tintColor;
    [self addSubview:_bar];
    [_bar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(UI_SCALE(40));
        make.top.equalTo(lineTop.mas_bottom);
    }];
    
    //线
    UIView *lineBottom = [self createLine];
    [lineBottom mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bar.mas_bottom);
    }];
    
    
    //取消按钮
    _cancelButton = [self createButtonWithTitle:globalConfiguration.cancelText titleColor:globalConfiguration.cancelTextColor action:@selector(actionCancel)];
    [_bar addSubview:_cancelButton];
    [_cancelButton mas_updateConstraints:^(MASConstraintMaker *make){
        make.centerY.left.mas_equalTo(_bar);
    }];
    
    //确定按钮
    _confirmButton = [self createButtonWithTitle:globalConfiguration.confirmText titleColor:globalConfiguration.confirmTextColor action:@selector(actionConfirm)];
    [_bar addSubview:_confirmButton];
    [_confirmButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.right.mas_equalTo(_bar);
    }];
    
    CGFloat margin = UI_IS_IPHONE_X ? 33 : 0;
    
    //内容视图
    _contentView = [[UIView alloc] init];
    [self addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.equalTo(lineBottom.mas_bottom);
        make.bottom.mas_equalTo(- margin);
    }];
    
}

- (UIView *)createLine{
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithRed:0.33 green:0.30 blue:0.28 alpha:0.3];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
    return line;
    
}
- (UIButton *)createButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor action:(SEL)action{
    
    UIButton *button = [UIButton mm_buttonWithTarget:self action:action];
    button.titleLabel.font = [JZBasicPickerConfiguration globalConfiguration].textFont;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(UI_SCALE(80));
        make.height.mas_equalTo(UI_SCALE(40));
    }];
    
    return button;
    
}

#pragma mark - Action
- (void)actionCancel{
    
    [self hide];
    
    if ([self respondsToSelector:@selector(jz_actionWhenCancelButtonClicked)]) {
        
        [self jz_actionWhenCancelButtonClicked];
        
    }
    
}
- (void)actionConfirm{
    
    [self hide];
    
    if ([self respondsToSelector:@selector(jz_actionWhenConfirmButtonClicked)]) {
        
        [self jz_actionWhenConfirmButtonClicked];
        
    }
    
}
#pragma mark - MMPopupWindowWildToHideProtocol
- (void)touchwildToHideHandler{
    
    if ([self respondsToSelector:@selector(jz_actionWhenCancelButtonClicked)]) {
        
        [self jz_actionWhenCancelButtonClicked];
        
    }
}

@end
