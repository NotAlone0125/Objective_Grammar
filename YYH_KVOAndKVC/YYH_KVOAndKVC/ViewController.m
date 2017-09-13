//
//  ViewController.m
//  YYH_KVOAndKVC
//
//  Created by 杨昱航 on 2017/6/12.
//  Copyright © 2017年 杨昱航. All rights reserved.
//

#import "ViewController.h"
#import <Foundation/Foundation.h>

#import "Person.h"
#import "WorkingGroup.h"
#import "Team.h"
#import "Creature.h"
#import "Dragon.h"
@interface ViewController ()
{
    WorkingGroup * agroup;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    static NSString * keys[]={@"name",@"email",@"age"};
    
    id obj=[[Person alloc]init];
    
    /*
     - (void)setValue:(nullable id)value forKey:(NSString *)key;
     将键字符串key所对应的属性的值设置为value，不能设定属性时，将引起接收器调用
     - (void)setValue:(nullable id)value forUndefinedKey:(NSString *)key;
    */
    [obj setValue:@"yyh" forKey:@"name"];
    [obj setValue:@"yyh@xiajoy.com" forKey:@"email"];
    [obj setValue:[NSNumber numberWithInt:25] forKey:@"age"];
    
    for (int i=0; keys[i]; i++)
    {
        /*
         - (nullable id)valueForKey:(NSString *)key;
         返回表示属性的键字符串所对应的值，如果不能取得值，则将引起接收器调用
         - (nullable id)valueForUndefinedKey:(NSString *)key;
         */
        NSLog(@"%@:%@",keys[i],[obj valueForKey:keys[i]]);
    }
    
    
    /*
     键值编码valueForKey：的具体行为：
     1.接收器中如果有name访问器（或getName、isName、_name、_getName）则使用它。
     2.没有访问器时，使用接收器的类方法accessInstancevariabsDirectly来查询，返回YES时，如果存在实例变量name(或_name,isName,_isName等)则返回其值。
     3.既没有访问器也没有实例变量时，将引起接收器调用方法setValue:forUndefinedKey:。
     4.应该返回的值如果不是对象，则返回被适当的对象包装的值。
     */
    
    
    /*
     +(BOOL)accessInstanceVariablesDirectly
     通常定义为返回YES，可以在子类中改变。该类方法返回YES时，使用键值编码可以访问该类的实例变量。返回NO时不可以访问。只要该方法返回YES，实例变量的可视属性即时有@private修饰，也可以访问。
     */
    
    
    /*
     -(id)valueForUndefinedKey:(NSString *)key
     不能取得键字符串对应的值时，从方法valuesForkey：中调用该方法，默认情况下，该方法的执行会触发异常NSUndefinedKeyException。不过，通过在子类中修改定义，就可以返回其他对象。
     */
    
    
    /*
     setValue:forKey:的具体行为：
     1.接收器中如果有setName访问器（或_setName）则使用它。set后面的键的第一个字母必须大写。也就是说setname是无法识别的。
     2.没有访问器时，使用接收器的类方法accessInstancevariabsDirectly来查询，返回YES时，如果存在实例变量name(或_name,isName,_isName等)则设定其值。使用引用计数管理方式时，实例变量如果为对象，则旧值会被自动释放，新值被保存并代入。
     3.既没有访问器也没有实例变量时，将引起接收器调用方法setValue:forUndefinedKey:。
     4.如果应该设定的值不是对象，则将变换到合适值。
     */
    
    /*
     setValue:forUndefinedKey:
     不能设置键字符串key对应的属性值时，从方法setValue:forkey中调用该方法。默认情况下，该方法的执行会触发异常NSUndefinedKeyException。不过，通过在子类中修改定义，就可以返回其他对象。
     */
    
    //[self keyPath];
    
    //[self keyArray];
    
    //[self kvcIndex];
    
    [self KVOSample];
}



#pragma mark 属性值得自动转换
//整数，实数或者BOOl值使用NSNumber包装，例如上面的age。
//NSPoint,NSRange,NSSize,NSRect使用NSValue包装。




#pragma mark 字典对象和键值编码
//字典类NSDictionary和NSMutableDictionary包含了NSKeyValueCoding协议，因此可以进行键值编码
/*
 -(id)valueForKey:(NSString *)key
 键字符串开头不是“@”时，将调用方法objecForKey:。开头如果为“@“,则将去除开头字符后剩余的字符串作为键，调用超类的方法valueForKey：。
 -(void)setValue:(id)value forKey:(NSString *)key
 一般会调用方法setObject:forKey：，参数value为nil时，则调用removeObjectForKey：删除键对应的对象。
 */



#pragma mark 根据键值路径进行访问
//属性为对象时，该对象还可能持有属性，例如存在类workingGroup，存在Person类的实例变量leader。
/*
 - (nullable id)valueForKeyPath:(NSString *)keyPath;
以点切分键路径，并使用第一个键想接收器发送valueForkey：方法。然后，在使用键路径的下个键，向得到的对象发送valueForKey：方法，如此反复操作，返回最后获得的对象。
 - (void)setValue:(nullable id)value forKeyPath:(NSString *)keyPath;
 与valueForkeyPath:方法同样取出对象，这里只对路径中的最后一个键调用setValue：forkey：方法，并设定属性值为Value。
 */
-(void)keyPath
{
    Person * leader=[[Person alloc]init];
    [leader setValue:@"pathName" forKey:@"name"];
    
    agroup=[[WorkingGroup alloc]initWithLeader:leader];
    
    id name_1=[agroup valueForKeyPath:@"leader.name"];
    
    NSLog(@"leader.name_1--%@",name_1);
    
    [agroup setValue:@"changeName" forKeyPath:@"leader.name"];
    
    id name_2=[agroup valueForKeyPath:@"leader.name"];
    
    NSLog(@"leader.name_2--%@",name_2);
}



#pragma mark 一对一关系和一对多关系
//用键字符串或键路制定属性时存在两种情况，一种取得的值仅限一个，一种是可以获得多个值得集合。（例如Workgroup的members变量，里面含有多个Person对象，@“members.name”,对应着与数组个数相同的人名）。
/*
 关于一对多关系属性的访问、更改，需要留意以下几点
 1.使用集合元素对象持有的键访问一对多关系属性时，键对应的属性被作为数组或集合返回。
 2.使用集合元素对象持有的键设定一对多关系属性时，各元素对象键对应的属性全部被更改。
 */
-(void)keyArray
{
    WorkingGroup * group;
    
    id chief=[[Person alloc]init];
    [chief setValue:@"yyh" forKey:@"name"];
    [chief setValue:[NSNumber numberWithInt:25] forKey:@"age"];
    
    id staff1=[[Person alloc]init];
    [staff1 setValue:@"yh" forKey:@"name"];
    [staff1 setValue:[NSNumber numberWithInt:24] forKey:@"age"];
    
    id staff2=[[Person alloc]init];
    [staff2 setValue:@"y" forKey:@"name"];
    [staff2 setValue:[NSNumber numberWithInt:23] forKey:@"age"];
    
    group=[[WorkingGroup alloc]initWithLeader:chief];
    [group addMember:staff1];
    [group addMember:staff2];
    
    NSLog(@"1--%@",[group valueForKeyPath:@"leader.name"]);
    NSLog(@"2--%@",[group valueForKeyPath:@"members.name"]);
    NSLog(@"3--%@",[group valueForKeyPath:@"members.name"]);
    
    [group setValue:@"hs" forKeyPath:@"leader.name"];
    [group setValue:[NSNumber numberWithInt:10] forKeyPath:@"members.age"];
    
    NSLog(@"4--%@",[group valueForKeyPath:@"leader.name"]);
    NSLog(@"5--%@",[group valueForKeyPath:@"members.age"]);
}


#pragma mark 数组对象和键值编码
//数组类NSArray和NSMutableArray以及集合类NSSet和NSMutableSet都包含NSKeyValueCoding的方法，也都有键值编码。
/*
 -(id)valueForKey:(NSString *)key
以key为参数，对集合的各元素调用方法valueForKey：后返回数组（NSSet时返回集合）。对各成员适用方法valueForKey：，返回nil时，则包含NSNull实例。
 -(void)setValue:(id)value forKey:(NSString *)key
对集合各元素调用方法setValue:forKey：。需要注意的是，即使集合对象自身不可以改变，也能调用该方法。
 */



#pragma mark 一对多关系的访问
//带索引的访问器模式
/*
 包含一对多关系的属性也可以像其他属性一样访问，但访问用户自定义类中包含的各元素对象的方法却有些不同。从键值编码方面来说，如果该属性也能像数组对象那样处理，使用起来就简单多了。
 即使是非数组对象，如果有某个模式的访问器，也可以进行像数组一样的键值编码操作。该访问器模式称为带索引的访问器模式。
 -(NSUInterger)countOf___;
 -(id)objectIn___AtIndex:(NSUInterger:)index;
 
 */
-(void)kvcIndex
{
    id obj;
    id aTeam=[[Team alloc]init];
    [aTeam addSomeone:@"YYH"];
    [aTeam addSomeone:@"HS"];
    obj=[aTeam valueForKey:@"fellows"];
    NSLog(@"obj=%@",NSStringFromClass([obj class]));
    NSLog(@"fellows:%@",obj);
    
    //我们调用 valueForKey:@"fellows" 时，KVC会为我们返回一个可以响应NSArray所有方法的代理数组对象(NSKeyValueArray)，这是NSArray的子类， - (NSUInteger)countOfFellows 决定了这个代理数组的容量， - (id)objectInFellowsAtIndex:(NSUInteger)index 决定了代理数组的内容。本例中使用的key是fellows，同理的如果key叫human，KVC就会去寻找 -countOfHuman:
}
//一对多关系的可变访问
/*
 实现之前说明的带索引的访问器模式后，使接收器对象内看起来包含了常数数组，而除此以外也可以包含可变数组。该可变数组不仅包含属性的元素对象，添加或删除数组元素后，也会联动追加或删除属性元素。
 -(NSMutableArray *)mutableArrayValueForKey:(NSString *)key
 返回相当于键字符串指定的一对多关系的属性的可变数组。操作被返回的数组与操作属性同时进行。
 -(NSMutableArray *)mutableArrayValueForKeyPath:(NSString *)keyPath
 接收器属性在路径中指定，其他与上述方法相同。
 
 除了带索引访问器模式中的两个方法外，还需要实现用来插入和删除的方法
 -(void)insertObject:(id)obj in___AtIndex:(NSUInterger):index;
 -(void)removeObjectFrom___AtIndex:(NSUInterger):index;
 
 -(void)set___:(id)anArray;
在实现该方法时，通过使用被作为参数传入的数组元素对象，就可以置换一对多关系的全部属性内容。
 
 除此以外还有替换的方法
 -(void)replaceObjectIn___AtIndex:(NSUInterger):index withObject:(id)obj;
 
 */




#pragma mark KVC标准
//验证属性值
/*
 通过使用键值编码，可以在属性名中自动选择访问器或者直接修改实例变量的值。然而在某些情况下，如果预期之外的对象被设定为了属性值，那么就可能出现问题。
 因此，在为某属性带入对象钱，为了验证该对象是否有误，可以使用相应的方法来验证。但是该验证方法不能自动调用，因此，在访问属性前，必须自行调用该方法。
 
 验证某键字符串的属性值的方法可按如下形式定义。下划线中写入键字符串。参数ioValue为需要验证的对象指针。参数outErro被用来当验证结果中存在问题时返回出错信息。
 -(BOOL)validate___:(inout id*)ioValue error:(out NSError**)outError
 要验证的对象没问题时，返回YES；
 对象有问题，但能将对象值修正为有效值时，方法会创建新的对象，并取代原对象将新对象带入ioValue，参数outError不变，返回值为YES；
 对象有问题且不能修正，返回NO；
 设定属性值的访问器方法（set___:）不能调用验证方法。
 
 
 运行时键会被动态地赋值给对象的情况下，不能在代码中使用上述方法名。此时可以使用下面的两个方法。
 -(BOOL)validateValue:(inout id  _Nullable __autoreleasing *)ioValue forKey:(nonnull NSString *)inKey error:(out NSError * _Nullable __autoreleasing * _Nullable)outError
 使用指定键寻找validate___:error:的验证方法并调用，如果不存在这样的方法则返回YES；
 
 -(BOOL)validateValue:(inout id  _Nullable __autoreleasing *)ioValue forKeyPath:(NSString *)inKeyPath error:(out NSError * _Nullable __autoreleasing *)outError
 与上述方法的不同之处在于键路径的制定。需要注意的是，实际被调用的验证方法并不是该方法的接收器，而是与最后的键元素相对应的属性的验证方法。
 */

//键值编码的准则
//Property为属性（标量值或单纯型的对象）或一对一关系时，要想成为KVC准则，就需要满足如下条件。属性名为”name“。
/*
 1.(a)实现了name或isName访问器方法。或者
   (b)包含name（或_name）实例变量。
 2.可变属性时，还需要实现setName:方法。需要执行键值验证时，要实现验证方法。但是setName:方法中不能调用验证方法。
 */
//属性为一对多关系时，要想成为KVC准则，需满足如下条件。属性名为“names”
/*
 1.(a)实现了返回数组的names方法。或者
   (b)持有包含names（或names）数组对象的实例变量。或者
   (c)实现了带索引的访问器模式的方法countOfName以及objectInNamesAtIndex：。
 2.当一对多关系的属性可变时
   (a)持有返回可变数组对象的names方法，或者
 (b)实现了带索引的访问器模式的方法 insertObject:inNamesAtIndex:,
 removeObjectFromNamesAtIndex:。
 */



#pragma mark 键值观察KVO
//即某个对象的属性改变时通知其他对象的机制。对被观察对象来说，键值观察就是注册想要监视的属性的键路径和观察者，当属性改变时，观察者会接收到消息；虽然和通知相类似，但键值观察中不存在相当于通知中心的对象，所以不可以指定消息的选择器。
/*
 NSObject中提供了键值观察所必须的方法，头文件Foundation/NSKeyValueObserving.h中将其定义为了非正式协议的形式。
 首先，需要使用下面的方法注册键值观察。
 -(void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
 options中制定字典数据中包含什么样的值，NSKeyValueObservingOptionNew = 提供属性改变后的值,
 NSKeyValueObservingOptionOld = 提供属性改变前的值,
 
 使用上述方法后，当指定监视的属性改变时，下面的消息将被发送给观察者
 -(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
 
 被作为通知消息的参数传入的字典change中保存着入口的键字符串及其内容
 
 NSKeyValueChangeKindKey;表示属性改变的种类，该入口值为包含整数的NSNumber实例，该整数位NSKeyValueChangeSetting时，表示保存着和属性不同的值。其他值为下面三个，使用一对多关系的可变数组来表示元素对象的改变NSKeyValueChangeInsertion插入、NSKeyValueChangeRemoval删除、NSKeyValueChangeReplacement置换。
 NSKeyValueChangeNewKey;如果观察者注册时，如果用选项指定了NSKeyValueObservingOptionNew，则属性更新后的信息会被保存。所保存的对象因改变的类型（NSKeyValueChangeKindKey）而异。属性中保存有新对象时，该新对象为入口值。对可变数组进行了插入、置换时，包含新元素的数组（NSArray）为入口值。
 NSKeyValueChangeOldKey;与NSKeyValueChangeNewKey类似。
 NSKeyValueChangeIndexesKey;动态数组中进行了插入、删除、置换时，表示执行了这些操作的索引集合--NSIndexSet类的实例为入口值。
 
 移除已注册的监视
 -(void)removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath
 */


//KVO示例
-(void)KVOSample
{
    int opt=NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld;//接收改变前后的值
    
    People * p1,* p2;
    Dragon * dra;
    p1=[[People alloc]initWithName:@"YYH" hitPoint:500];
    p2=[[People alloc]initWithName:@"YH" hitPoint:140];
    dra=[[Dragon alloc]initWithName:@"HS" hitPoint:400];
    dra.master=p1;
    
    [dra addObserver:dra forKeyPath:@"master.hitPoint" options:opt context:NULL];
    
    [p1 addObserver:p2 forKeyPath:@"hitPoint" options:opt context:NULL];
    
    [p1 setHitPoint:800];//改变p1的hitPoint,并向p2和dra发送了消息
    [p1 sufferDamage:200];//虽然调用了更改hitPoint的消息sufferDamage：，但是是使用非KVC准则的消息改变属性，成为监视外的对象，并没有收到相应的通知。
    dra.master=p2;//这时将收到master.hitPoint被改变的消息，即使不是指定键路径的属性，在产生改变时也会被通知。
    p1.hitPoint-=100;
    p2.hitPoint+=200;
    [dra removeObserver:dra forKeyPath:@"master.hitPoint"];//删除后无法监视
    p2.hitPoint-=300;
    [p1 removeObserver:p2 forKeyPath:@"hitPoint"];
}



#pragma mark 依赖键的登记
//某属性随着同一对象的其他属性的改变而改变是常有的事情。通过事先将这样的依赖关系在类中注册，那么即便属性值间接地发生了改变，也会发送通知消息，为此需要使用下面的类方法
+(void)setKeys:(NSArray *)keys triggerChangeNotificationForDependtKey:(NSString *)dependtKey;
{
    //数组keys中可以保存多个键。注册依赖关系，使当这些键中任意一个键对应的属性发生改变时，都会自动引起与键dependentKey的属性变化时一样的行为（被监视时发送通知）。
}
/*
 例如，Person类中有image属性，该属性保存有weapon（武器）、amor（铠甲）、helmet（头盔）以及用来表示人物的图片。假设根据所持有的武器、铠甲、头盔的不同，图片也不一样。那么，当改变持有的物品时，就需要重绘图片。因此，与其分别监视武器、铠甲、头盔，不如设定他们之间的依赖关系，这样只监视图片就行了，程序也会变得简单
 */


@end
