const EventTriggerDefinition = @import("event_trigger_definition.zig").EventTriggerDefinition;

/// Identifies
pub const LambdaResource = struct {
    /// The array of ARNs for S3Resource objects to trigger the LambdaResource
    /// objects associated with this job.
    event_triggers: ?[]const EventTriggerDefinition = null,

    /// An Amazon Resource Name (ARN) that represents an Lambda function to be
    /// triggered by PUT object actions on the associated local Amazon S3 resource.
    lambda_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .event_triggers = "EventTriggers",
        .lambda_arn = "LambdaArn",
    };
};
