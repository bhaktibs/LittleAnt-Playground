//: Playground - noun: a place where people can play

import UIKit
import CoreGraphics
import PlaygroundSupport
import XCPlayground
import AVFoundation

//Responder class is created to handle button pressed event
class Responder : NSObject {

  func action() {
        button.isHidden=true
       show_ant()
    label_1.text=""
    begin()
    
    }
    //This method is called to create animation at the end
    func create_view()
    {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 90, height: 90))
        hostView.addSubview(view)
        view.addSubview(ant)
        UIView.animate(withDuration:10, delay:0.2, options: [.curveEaseOut], animations: {
            view.center.y -= view.frame.size.height
        }, completion: {
            (value: Bool) in
            view.layer.removeAllAnimations()})
    }
   
   
    
}
//Begins here: where parent View (hostView) and other childeren are added to the view.
let color = UIColor(red: 0.0902, green: 0.0392, blue: 0.498, alpha: 1)
let hostView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 500))

let background_image  = UIImage(named: "images.jpeg")
let backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 500))
backgroundImage.image=background_image
hostView.addSubview(backgroundImage)
let ant = UIImageView(image: UIImage(named:"ant.png"))
ant.frame=CGRect(x: 100, y: 100, width: 50, height: 50)
let label = UILabel(frame:CGRect(x: 10, y: 0, width:250, height: 100))
label.lineBreakMode = NSLineBreakMode.byWordWrapping
label.numberOfLines = 7
let label_1 = UILabel(frame:CGRect(x: 10, y: 0, width:280, height: 490))
label_1.lineBreakMode = NSLineBreakMode.byWordWrapping
label_1.numberOfLines = 15
label_1.font = UIFont.init(name: "Arial", size: 14)
label.textColor=color
hostView.addSubview(label)
hostView.addSubview(label_1)
let responder = Responder()

let button = UIButton(frame: CGRect(x: 100, y: 100, width: 75, height: 40))
button.backgroundColor=UIColor.darkGray
button.setTitle("START", for: .normal)
button.addTarget(responder, action: #selector(Responder.action), for: .touchUpInside)
var backgroundMusic: AVAudioPlayer!
let path = Bundle.main.path(forResource: "music_1.mp3", ofType:nil)!
let url = URL(fileURLWithPath: path)
do {
    let sound = try AVAudioPlayer(contentsOf: url)
    backgroundMusic = sound
    sound.play()
    
} catch {
    // couldn't load file :(
}

//to display intial welcome message
func display_message(msg:String)
{
    
    label.text=msg
    
}
//display other messges on the screen
func display_message_1(msg:String)
{
    label.text=""
    label_1.text=msg
    
}
//to include ant in the parent view
func show_ant()
    {
//
       hostView.addSubview(ant)

    }


display_message(msg:"Hello and Welcome!!!")

//timer is set to cause deplay between two methods
let timer_1 = Timer.scheduledTimer(withTimeInterval:2, repeats: false) { (t) in
  display_message_1(msg: "Let a Little Ant tell you how your day will be!!!\n Ant has three options of candy to choose from. Depening on which candy ant finds first and in total number of tries, she will narrate your future.If ant finds a candy in the first chance,that's consider most lucky day for your like.")
    hostView.addSubview(button)
}
//once all the views are created and welcome message is shown, this method is called to begin the ant activity
func begin()
{
   
    func random_x_position() -> Int
    {
        var x = arc4random_uniform(UInt32(hostView.frame.width-50))
        return Int(x)
    }
    func random_y_position() -> Int
    {
        var y = arc4random_uniform(UInt32(hostView.frame.height-50))
        
        return Int(y)
    }
    
    var counter = 0
    
    let candy1 = UIImageView(image: UIImage(named:"candy1.png"))
    candy1.frame=CGRect(x:random_x_position(), y: random_y_position(), width: 30, height: 20)
    let candy2 = UIImageView(image: UIImage(named:"candy2.png"))
    candy2.frame=CGRect(x: random_x_position(), y: random_y_position(), width: 30, height: 50)
    let candy3 = UIImageView(image: UIImage(named:"candy3.png"))
    candy3.frame=CGRect(x: random_x_position(), y: random_y_position(), width: 20, height: 20)
    hostView.addSubview(candy1)
    hostView.addSubview(candy2)
    hostView.addSubview(candy3)
    
    func hideObjects(value1: Bool,value2: Bool,value3: Bool)
{
    
    candy1.isHidden=value1
    candy2.isHidden=value2
    candy3.isHidden=value3
    }
    let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (t) in
        //moveAnt()
        //timer_1.invalidate()

        display_message_1(msg: "")
        counter += 1
        ant.frame = CGRect(x:random_x_position(), y:random_y_position(), width: 50, height: 50)
        
    }
    
   
    let timer_4 = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (t) in
        if(candy1.frame.intersects(ant.frame) || candy2.frame.intersects(ant.frame) || candy3.frame.intersects(ant.frame) )
        {
            timer.invalidate()
            end_all()
            
            if(counter==1)
            {
                hideObjects(value1: true,value2: true,value3: true)
                label_1.textColor=UIColor.red
                responder.create_view()
                
                display_message_1(msg: "A little ant says: You will have super Fantastic day.. Your lucky number is 1. Wear Blue today. You can have opportunity to start some new creative things.You might meet a very old friend.Ohh yes, dont forget to get a lotto!!... ")
                
            }
            else if(candy1.frame.intersects(ant.frame))
            {
                hideObjects(value1: false,value2: true,value3: true)
                responder.create_view()
                
                display_message_1(msg:"A little ant says: you might be meeting someone special today. Your lucky number is 4. Wear Red,the color of love.Try to avoid conflits....")
                
            }
            else if(candy2.frame.intersects(ant.frame))
            {
                hideObjects(value1: true,value2: false,value3: true)
                responder.create_view()
                display_message_1(msg:"A little ant says: You can see a potential opportunity for your career.Lucky number is 3. Wear something professional.Try to engage with new people. Talk to some recruiters and carrer advisors...")
                
            }
            else if(candy3.frame.intersects(ant.frame))
            {
                hideObjects(value1: true,value2: true,value3: false)
                responder.create_view()
                display_message_1(msg:"A little ant says: You're more emotionally sensitive today and you prefer to avoid any long and drawn out discussions. In fact, the witty retorts you usually keep on hand seem fewer in number now. Your words fail to express your deeper feelings when your key planet Mercury drifts into your 12th House of Destiny, encouraging introspection over connection. You may even get a peek at unpublished chapters of your story as you explore the hallways of your imagination. Dieter Uchtdorf wrote,The desire to create is one of the deepest yearnings of the human soul.your lucky number is 5.Lucky color:Pink")
                
            }
            else if(counter>10)
            {
                responder.create_view()
                display_message_1(msg:"A little ant says: You don't want to take anyone's word for anything today. You must verify the facts and see the evidence with your own eyes. While you're quick to gather data, you need a bit longer to digest what you learn. Fortunately, you can turn a jumble of bits and pieces into a useful set of knowledge as long as you don't rush the process. You will know when the time is right once everything falls into place.Your lcuky number is 9.Lucky color: Purple")
                
            }
            
        }
    }
    
}

 //end_all invalidates the timer so can stop running
   func end_all()
        {
            
            timer_1.invalidate()
            
    }

    
    
    

PlaygroundPage.current.liveView=hostView;




