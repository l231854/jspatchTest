require("UIButton, UIScreen, UIColor,NativeViewController");
defineClass('JPViewController',{
    viewDidLoad: function() {
       self.ORIGviewDidLoad();
            console.log('viewDidLoad');
            var button = UIButton.alloc().initWithFrame({x:0, y:160, width:UIScreen.mainScreen().bounds().width, height:50});
            button.setBackgroundColor(UIColor.redColor());
            button.setTitle_forState('button', 0);
            button.addTarget_action_forControlEvents(self, "handleBtn2:", 1 <<  6);
            self.view().addSubview(button);
            var button2 = UIButton.alloc().initWithFrame({x:0, y:260, width:UIScreen.mainScreen().bounds().width, height:50});
            button2.setBackgroundColor(UIColor.redColor());
            button2.setTitle_forState('button2', 0);
            button2.addTarget_action_forControlEvents(self, "handleBtn2:", 1 <<  6);
            self.view().addSubview(button2);
    }
})
defineClass('JPViewController', {
  handleBtn2: function(sender) {
    var www = NativeViewController.alloc().init()
    self.navigationController().pushViewController_animated(www, YES)
  }
})
defineClass('JPViewController', {
            handleBtn: function(sender) {
            var tableViewCtrl = JPTableViewController.alloc().init()
            self.navigationController().pushViewController_animated(tableViewCtrl, YES)
            }
})

defineClass('JPTableViewController : UITableViewController <UIAlertViewDelegate>', ['data'], {
  dataSource: function() {
    var data = self.data();
    if (data) return data;
    var data = [];
    for (var i = 0; i < 20; i ++) {
      data.push("cell from js " + i);
    }
    self.setData(data)
    return data;
  },
  numberOfSectionsInTableView: function(tableView) {
    return 1;
  },
  tableView_numberOfRowsInSection: function(tableView, section) {
    return self.dataSource().length;
  },
  tableView_cellForRowAtIndexPath: function(tableView, indexPath) {
    var cell = tableView.dequeueReusableCellWithIdentifier("cell") 
    if (!cell) {
      cell = require('UITableViewCell').alloc().initWithStyle_reuseIdentifier(0, "cell")
    }
    cell.textLabel().setText(self.dataSource()[indexPath.row()])
    return cell
  },
  tableView_heightForRowAtIndexPath: function(tableView, indexPath) {
    return 60
  },
  tableView_didSelectRowAtIndexPath: function(tableView, indexPath) {
     var alertView = require('UIAlertView').alloc().initWithTitle_message_delegate_cancelButtonTitle_otherButtonTitles("Alert",self.dataSource()[indexPath.row()], self, "OK",  null);
     alertView.show()
  },
  alertView_willDismissWithButtonIndex: function(alertView, idx) {
    console.log('click btn ' + alertView.buttonTitleAtIndex(idx).toJS())
  }
  
})
