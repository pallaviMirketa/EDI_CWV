({
    doInit: function (component, event, helper) {
        component.set("v.showSpinner", true);
        var recordId = component.get('v.recordId');
        console.log('recordId '+recordId);
        var action = component.get('c.getJSONtoReconcile');
        action.setParams({ recordId : recordId });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (response !== null && state == "SUCCESS" ) {
                 console.log('response @' + response);
                if(response.getReturnValue() == '835'){
                    helper.showToast('Success','EDI-835 Reconciled','Success');
                }else if(response.getReturnValue() == '999'){
                     console.log('Checking EDi 999');
                    helper.showToast('Success','EDI-999 Parsed Successfully','Success');
                }
            }
            else{
                 //console.log('Reconcilation part');
                var toastMessage = 'EDI 835 Reconcilation failed';
                var errors = response.getError();
                if (errors && errors[0] && errors[0].message) {
                    toastMessage = errors[0].message;
                }
                helper.showToast('Error',toastMessage,'Error');
                $A.get("e.force:closeQuickAction").fire();
            }
           
            component.set("v.showSpinner", false);
            console.log('Spinner is false now');
        });
        $A.enqueueAction(action);
    }
})