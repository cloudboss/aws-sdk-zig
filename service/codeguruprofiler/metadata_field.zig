const std = @import("std");

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
        .compute_platform = "ComputePlatform",
        .agent_id = "AgentId",
        .aws_request_id = "AwsRequestId",
        .execution_environment = "ExecutionEnvironment",
        .lambda_function_arn = "LambdaFunctionArn",
        .lambda_memory_limit_in_mb = "LambdaMemoryLimitInMB",
        .lambda_remaining_time_in_milliseconds = "LambdaRemainingTimeInMilliseconds",
        .lambda_time_gap_between_invokes_in_milliseconds = "LambdaTimeGapBetweenInvokesInMilliseconds",
        .lambda_previous_execution_time_in_milliseconds = "LambdaPreviousExecutionTimeInMilliseconds",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .compute_platform => "ComputePlatform",
            .agent_id => "AgentId",
            .aws_request_id => "AwsRequestId",
            .execution_environment => "ExecutionEnvironment",
            .lambda_function_arn => "LambdaFunctionArn",
            .lambda_memory_limit_in_mb => "LambdaMemoryLimitInMB",
            .lambda_remaining_time_in_milliseconds => "LambdaRemainingTimeInMilliseconds",
            .lambda_time_gap_between_invokes_in_milliseconds => "LambdaTimeGapBetweenInvokesInMilliseconds",
            .lambda_previous_execution_time_in_milliseconds => "LambdaPreviousExecutionTimeInMilliseconds",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
