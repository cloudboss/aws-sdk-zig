const DestinationConfig = @import("destination_config.zig").DestinationConfig;

pub const FunctionEventInvokeConfig = struct {
    /// A destination for events after they have been sent to a function for
    /// processing. **Destinations**
    ///
    /// * **Function** - The Amazon Resource Name (ARN) of a Lambda function.
    /// * **Queue** - The ARN of a standard SQS queue.
    /// * **Bucket** - The ARN of an Amazon S3 bucket.
    /// * **Topic** - The ARN of a standard SNS topic.
    /// * **Event Bus** - The ARN of an Amazon EventBridge event bus.
    ///
    /// **Note:**
    ///
    /// S3 buckets are supported only for on-failure destinations. To retain records
    /// of successful invocations, use another destination type.
    destination_config: ?DestinationConfig,

    /// The Amazon Resource Name (ARN) of the function.
    function_arn: ?[]const u8,

    /// The date and time that the configuration was last updated.
    last_modified: ?i64,

    /// The maximum age of a request that Lambda sends to a function for processing.
    maximum_event_age_in_seconds: ?i32,

    /// The maximum number of times to retry when the function returns an error.
    maximum_retry_attempts: ?i32,
};
