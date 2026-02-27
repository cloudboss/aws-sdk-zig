pub const MetadataField = enum {
    /// Compute platform on which agent is running.
    compute_platform,
    /// Unique identifier for the agent instance.
    agent_id,
    /// AWS requestId of the Lambda invocation.
    aws_request_id,
    /// Execution environment on which Lambda function is running.
    execution_environment,
    /// Function ARN that's used to invoke the Lambda function.
    lambda_function_arn,
    /// Memory allocated for the Lambda function.
    lambda_memory_limit_in_mb,
    /// Time in milliseconds left before the execution times out.
    lambda_remaining_time_in_milliseconds,
    /// Time in milliseconds between two invocations of the Lambda function.
    lambda_time_gap_between_invokes_in_milliseconds,
    /// Time in milliseconds for the previous Lambda invocation.
    lambda_previous_execution_time_in_milliseconds,

    pub const json_field_names = .{
        .compute_platform = "COMPUTE_PLATFORM",
        .agent_id = "AGENT_ID",
        .aws_request_id = "AWS_REQUEST_ID",
        .execution_environment = "EXECUTION_ENVIRONMENT",
        .lambda_function_arn = "LAMBDA_FUNCTION_ARN",
        .lambda_memory_limit_in_mb = "LAMBDA_MEMORY_LIMIT_IN_MB",
        .lambda_remaining_time_in_milliseconds = "LAMBDA_REMAINING_TIME_IN_MILLISECONDS",
        .lambda_time_gap_between_invokes_in_milliseconds = "LAMBDA_TIME_GAP_BETWEEN_INVOKES_IN_MILLISECONDS",
        .lambda_previous_execution_time_in_milliseconds = "LAMBDA_PREVIOUS_EXECUTION_TIME_IN_MILLISECONDS",
    };
};
