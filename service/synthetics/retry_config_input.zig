/// This structure contains information about the canary's retry configuration.
///
/// The default account level concurrent execution limit from Lambda is 1000.
/// When you have more than 1000 canaries, it's possible there are more than
/// 1000 Lambda invocations due to retries and the console might hang. For more
/// information on the Lambda execution limit,
/// see [Understanding Lambda function
/// scaling](https://docs.aws.amazon.com/lambda/latest/dg/lambda-concurrency.html#:~:text=As%20your%20functions%20receive%20more,functions%20in%20an%20AWS%20Region).
///
/// For canary with `MaxRetries = 2`, you need to set the
/// `CanaryRunConfigInput.TimeoutInSeconds` to less than 600 seconds to avoid
/// validation errors.
pub const RetryConfigInput = struct {
    /// The maximum number of retries. The value must be less than or equal to 2.
    max_retries: i32,

    pub const json_field_names = .{
        .max_retries = "MaxRetries",
    };
};
