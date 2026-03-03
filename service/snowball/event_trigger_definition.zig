/// The container for the EventTriggerDefinition$EventResourceARN.
pub const EventTriggerDefinition = struct {
    /// The Amazon Resource Name (ARN) for any local Amazon S3 resource that is an
    /// Lambda function's event trigger associated with this job.
    event_resource_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .event_resource_arn = "EventResourceARN",
    };
};
