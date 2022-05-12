exports.handler = async(event) => {
    console.log('ScheduledLambda was called');
    console.log('Event Details:' , JSON.stringify(event));
}