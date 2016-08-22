//
//  ViewController.m
//  test_iOS_intern
//
//  Created by Admin on 09.08.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ViewController.h"
#import "UITextFieldNoCopyPaste.h"
@interface ViewController ()

@end

@implementation ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.quantityOfCountsNum = 0;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)coutBtnPressed:(id)sender {
    if(![self.input.text  isEqualToString: @""]){
        //В задании говорилось:"в расчетах можно использовать только сложение" Посему возведение в степень было решено реализовать следующим циклом
        long long inputNumber = [self.input.text longLongValue];//можно было бы конечно конвертировать строку в тип unsigned long long, но ф-ции для перевода строки в конкретно данный тип - нет, а создавать дополнительную ф-цию затратно по времени.
        long long result = 0;
        for (long long i=0; i < inputNumber; i++){
            result += inputNumber;
        }
        self.quantityOfCountsNum++;
        self.result.text = [NSString stringWithFormat:@"%lli",result];
        self.quantityOfCounts.text = [NSString stringWithFormat:@"%lu",(unsigned long)self.quantityOfCountsNum];
    }else{
        self.result.text = @"результат";
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil message:@"Введите значение" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* okButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:okButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    
    
}

- (IBAction)refreshBtnPressed:(id)sender {
    self.quantityOfCountsNum = 0;
    self.input.text = nil;
    self.result.text = @"результат";
    self.quantityOfCounts.text = @"#";
}


#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"%@", textField.text);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSCharacterSet* validationSet = [[NSCharacterSet decimalDigitCharacterSet]invertedSet];
    
    //защита от ввода посторонних значений
    if([[string componentsSeparatedByCharactersInSet:validationSet] count]>1)
        return NO;
    
    //Иногда при большом колличестве вложений - лично мне легче расставлять фигурные скобки в стиле C++ :)
    
    if([textField.text isEqualToString:@"0"])   //если первым ввели нуль
    {
        
        if([string isEqualToString:@"0"])   //если после нуля снова вводится нуль - то последующее значение не записвается в поле ввода
            return NO;
        else    //если же после нуля вводится другое значение - то последующее значение не записвается в поле ввода - нуль заменяется на другое значение (так как защиту от ввода посторонних значений мы поставили в самом начале выполнения данной функции, то мы автоматическ защитились от ввода значений типа "0@", "0n", ...)
        {
            textField.text = nil;
            return YES;
        }
    }
    
    else    //во всех остальных случаях
        
    {
        NSString* resultString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if([resultString length] <= 8)
            //ограничение на длинну вводимого значения. Использование именно 8-ми знаков было выбранно из-за того, что мы переводим значение из строки ввода в тип long long, максимальное положительное значение у данного типа: (2^64)/2 = 9223372036854775808. Если мы извлечем квадратный корень из данного числа: sqrt(9223372036854775808) = 3037000499.97 - то результат нам покажет каким может быть максимальное значение для поля ввода. Так как пользователь должен иметь возможность вводить любые цифры, то в выборе колличества знаков нужно исходить из того, что он может ввести девятки во все разряды. Число 3037000499.97  располагает 10-ю разрядами, но так как пользователь может ввести все 10 знаков - одни девятки, тогда лучше для поля ввода использовать 9 знаков, но так как в задании говорилось:"в расчетах можно использовать только сложение", то установив 9 знаков для полля ввода  - программа из-за большого колличества итераций при рассчете квадрата числа начинала "тормозить" примерно на 2-3 секунды, было решено использовать 8 знаков. К тому же это символично с калькуляторами - у них разрядная сетка как правило имеет всега четное число знаков.
            return YES;
        else
        {
            //не уверен точно нужен ли в данном месте алерт-контроллер, просто если пользователь будет вводить большое число из одинковых цифр ему может показаться что они еще вводятся - просто ушли за границу поля ввода
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil message:@"Вводимое значение не может быть больше 8-ми разрядов" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* okButton = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:okButton];
            [self presentViewController:alert animated:YES completion:nil];
            return NO;
            
        }
    }
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    //странно, не смотря на то что и в настройках проекта указанно, что доступна только портретная ориентация, еще и в этой ф-ции указанно это - все равно при запуске приложения на айпаде - приложение можно повернуть
    return UIInterfaceOrientationMaskPortrait;
}

//- (BOOL)textFieldShouldReturn:(UITextField *)textField;              // called when 'return' key pressed. return NO to ignore.




@end
