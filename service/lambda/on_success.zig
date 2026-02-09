/// A destination for events that were processed successfully.
///
/// To retain records of successful [asynchronous
/// invocations](https://docs.aws.amazon.com/lambda/latest/dg/invocation-async.html#invocation-async-destinations), you can configure an Amazon SNS topic, Amazon SQS queue, Lambda function, or Amazon EventBridge event bus as the destination.
///
/// **Note:**
///
/// `OnSuccess` is not supported in `CreateEventSourceMapping` or
/// `UpdateEventSourceMapping` requests.
pub const OnSuccess = struct {
    /// The Amazon Resource Name (ARN) of the destination resource.
    ///
    /// **Note:**
    ///
    /// Amazon SNS destinations have a message size limit of 256 KB. If the combined
    /// size of the function request and response payload exceeds the limit, Lambda
    /// will drop the payload when sending `OnFailure` event to the destination. For
    /// details on this behavior, refer to [Retaining records of asynchronous
    /// invocations](https://docs.aws.amazon.com/lambda/latest/dg/invocation-async-retain-records.html).
    destination: ?[]const u8,
};
