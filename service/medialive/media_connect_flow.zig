/// The settings for a MediaConnect Flow.
pub const MediaConnectFlow = struct {
    /// The unique ARN of the MediaConnect Flow being used as a source.
    flow_arn: ?[]const u8,

    pub const json_field_names = .{
        .flow_arn = "FlowArn",
    };
};
