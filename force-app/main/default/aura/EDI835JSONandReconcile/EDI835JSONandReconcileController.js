({
    doInit: function (component, event, helper) {
        component.set("v.showSpinner", true);
        var recordId = component.get('v.recordId');
        console.log('recordId '+recordId);
        var action = component.get('c.getJSONtoReconcile');
        action.setParams({ recordId : recordId });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (!response == null && state === "SUCCESS") {
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Success',
                    message: 'EDI-835 Reconciled',
                    type: 'Success'
                });
                toastEvent.fire();
                $A.get("e.force:closeQuickAction").fire();
            }
            else{
                var toastMessage = 'Reconcilation failed';
                var errors = response.getError();
                if (errors && errors[0] && errors[0].message) {
                    toastMessage = errors[0].message;
                }
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    title : 'Error',
                    message: toastMessage,
                    type: 'Error'
                });
                toastEvent.fire();                
                
                $A.get("e.force:closeQuickAction").fire();
            }
            component.set("v.showSpinner", false);
            
        });
        $A.enqueueAction(action);
    }
})