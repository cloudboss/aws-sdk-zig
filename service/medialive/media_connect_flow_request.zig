/// The settings for a MediaConnect Flow.
pub const MediaConnectFlowRequest = struct {
    /// The ARN of the MediaConnect Flow that you want to use as a source.
    flow_arn: ?[]const u8,

    pub const json_field_names = .{
        .flow_arn = "FlowArn",
    };
};
