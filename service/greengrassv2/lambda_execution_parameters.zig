const aws = @import("aws");

const LambdaEventSource = @import("lambda_event_source.zig").LambdaEventSource;
const LambdaInputPayloadEncodingType = @import("lambda_input_payload_encoding_type.zig").LambdaInputPayloadEncodingType;
const LambdaLinuxProcessParams = @import("lambda_linux_process_params.zig").LambdaLinuxProcessParams;

/// Contains parameters for a Lambda function that runs on IoT Greengrass.
pub const LambdaExecutionParameters = struct {
    /// The map of environment variables that are available to the Lambda function
    /// when it
    /// runs.
    environment_variables: ?[]const aws.map.StringMapEntry = null,

    /// The list of event sources to which to subscribe to receive work messages.
    /// The Lambda
    /// function runs when it receives a message from an event source. You can
    /// subscribe this function
    /// to local publish/subscribe messages and Amazon Web Services IoT Core MQTT
    /// messages.
    event_sources: ?[]const LambdaEventSource = null,

    /// The list of arguments to pass to the Lambda function when it runs.
    exec_args: ?[]const []const u8 = null,

    /// The encoding type that the Lambda function supports.
    ///
    /// Default: `json`
    input_payload_encoding_type: ?LambdaInputPayloadEncodingType = null,

    /// The parameters for the Linux process that contains the Lambda function.
    linux_process_params: ?LambdaLinuxProcessParams = null,

    /// The maximum amount of time in seconds that a non-pinned Lambda function can
    /// idle before the
    /// IoT Greengrass Core software stops its process.
    max_idle_time_in_seconds: ?i32 = null,

    /// The maximum number of instances that a non-pinned Lambda function can run at
    /// the same
    /// time.
    max_instances_count: ?i32 = null,

    /// The maximum size of the message queue for the Lambda function component. The
    /// IoT Greengrass core
    /// stores messages in a FIFO (first-in-first-out) queue until it can run the
    /// Lambda function to
    /// consume each message.
    max_queue_size: ?i32 = null,

    /// Whether or not the Lambda function is pinned, or long-lived.
    ///
    /// * A pinned Lambda function starts when IoT Greengrass starts and keeps
    ///   running in its own
    /// container.
    ///
    /// * A non-pinned Lambda function starts only when it receives a work item and
    ///   exists after
    /// it idles for `maxIdleTimeInSeconds`. If the function has multiple work
    /// items,
    /// the IoT Greengrass Core software creates multiple instances of the function.
    ///
    /// Default: `true`
    pinned: ?bool = null,

    /// The interval in seconds at which a pinned (also known as long-lived) Lambda
    /// function
    /// component sends status updates to the Lambda manager component.
    status_timeout_in_seconds: ?i32 = null,

    /// The maximum amount of time in seconds that the Lambda function can process a
    /// work
    /// item.
    timeout_in_seconds: ?i32 = null,

    pub const json_field_names = .{
        .environment_variables = "environmentVariables",
        .event_sources = "eventSources",
        .exec_args = "execArgs",
        .input_payload_encoding_type = "inputPayloadEncodingType",
        .linux_process_params = "linuxProcessParams",
        .max_idle_time_in_seconds = "maxIdleTimeInSeconds",
        .max_instances_count = "maxInstancesCount",
        .max_queue_size = "maxQueueSize",
        .pinned = "pinned",
        .status_timeout_in_seconds = "statusTimeoutInSeconds",
        .timeout_in_seconds = "timeoutInSeconds",
    };
};
