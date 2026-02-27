/// An activity that runs a Lambda function to modify the message.
pub const LambdaActivity = struct {
    /// The number of messages passed to the Lambda function for processing.
    ///
    /// The Lambda function must be able to process all of these messages within
    /// five minutes,
    /// which is the maximum timeout duration for Lambda functions.
    batch_size: i32,

    /// The name of the Lambda function that is run on the message.
    lambda_name: []const u8,

    /// The name of the lambda activity.
    name: []const u8,

    /// The next activity in the pipeline.
    next: ?[]const u8,

    pub const json_field_names = .{
        .batch_size = "batchSize",
        .lambda_name = "lambdaName",
        .name = "name",
        .next = "next",
    };
};
