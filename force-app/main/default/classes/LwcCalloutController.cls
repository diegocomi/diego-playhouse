/**
 * Created by diego.cominazzini on 29/02/2024.
 */

public with sharing class LwcCalloutController {
    @AuraEnabled(cacheable=true)
    public static Object callAndRespond(String methodPath, Map<String,Object> inputData) {
        if(methodPath.containsNone('.') || methodPath.countMatches('.') > 0){
            throw new MalformedCallException('the method path expected should contain one dot');
        }
        String className = methodPath.substringBefore('.');
        String methodName = methodPath.substringAfterLast('.');
        Callable callInstance = (Callable) Type.forName(className).newInstance();
        return callInstance.call(methodName, inputData);
    }
}