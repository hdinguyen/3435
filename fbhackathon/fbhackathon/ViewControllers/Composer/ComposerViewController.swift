//
//  ComposerViewController.swift
//  fbhackathon
//
//  Created by Nguyenh on 7/30/16.
//  Copyright © 2016 3435. All rights reserved.
//

import UIKit

class ComposerViewController: BaseViewController, UITextViewDelegate {

    var composerHeight:CGFloat = 500
    
    let scrollView = UIScrollView(frame: CGRectZero)
    let contentComposer = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "New Skill"
        let frame = self.view.bounds
        scrollView.frame = frame
        self.view.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(scrollView)
        
        let coverImage = UIButton(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: 200))
        coverImage.backgroundColor = UIColor.yellowColor()
        scrollView.addSubview(coverImage)
        
        let profileImage = UIButton(frame: CGRect(x: 30, y: coverImage.frame.size.height - 70, width: 100, height: 100))
        profileImage.layer.cornerRadius = 50
        profileImage.layer.masksToBounds = true
        profileImage.layer.borderWidth = 1
        profileImage.layer.borderColor = UIColor.whiteColor().CGColor
        scrollView.addSubview(profileImage)
        
        contentComposer.frame = CGRect(x: 10, y: profileImage.frame.size.height + profileImage.frame.origin.y + 10, width: frame.size.width - 20, height: self.view.frame.height - 64 - 230 - 64)
        contentComposer.layer.borderColor = UIColor.lightGrayColor().CGColor
        contentComposer.layer.borderWidth = 1
        contentComposer.layer.cornerRadius = 3
        contentComposer.inputAccessoryView = self.createToolBar()
        
        
        scrollView.addSubview(contentComposer)
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: 0, height: frame.size.height + 10)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ComposerViewController.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ComposerViewController.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil);
        
        let submit = UIBarButtonItem(title: "Submit", style: .Done, target: self, action: #selector(ComposerViewController.donePressed))
        self.navigationItem.rightBarButtonItem = submit
    }
    
    func donePressed () {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func createToolBar() -> UIToolbar {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 30))
        toolbar.barStyle = .BlackTranslucent
        let done = UIBarButtonItem(title: "Done", style: .Done, target: self, action: #selector(ComposerViewController.dismiss))
        toolbar.items = [done]
        toolbar.sizeToFit()
        return toolbar
    }
    
    func dismiss()
    {
        contentComposer.resignFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardWillShow(sender: NSNotification) {
        if let keyboardSize = (sender.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue() {
            self.scrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - keyboardSize.height + 44)
            var composerFrame = contentComposer.frame
            composerFrame.size.height += 64
            contentComposer.frame = composerFrame
        }
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.scrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        var composerFrame = contentComposer.frame
        composerFrame.size.height -= 64
        contentComposer.frame = composerFrame
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        let att = NSAttributedString(string: textView.text, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(12)])
        let rect = att.boundingRectWithSize(CGSize(width: textView.frame.width, height: 1000), options: NSStringDrawingOptions.UsesLineFragmentOrigin, context: nil)
        if rect.size.height + 240 > self.view.frame.height {
            
        }
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 230
        }
        return composerHeight
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("author", forIndexPath: indexPath) as! AuthorTableViewCell
            cell.load("abc", editMode: true, size: CGSize(width: tableView.frame.size.width, height: 230))
            cell.selectionStyle = .None
            return cell
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("composer", forIndexPath: indexPath) as! DescriptionComposerTableViewCell
        cell.selectionStyle = .None
        cell.load(CGSize(width: tableView.frame.size.width, height: self.composerHeight + 10)) { (text, size) in
            self.composerHeight = size.height
            tableView.beginUpdates()
            tableView.endUpdates()
        }
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
