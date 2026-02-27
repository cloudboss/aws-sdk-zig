const Processor = @import("processor.zig").Processor;

/// Summary of details of a channel flow.
pub const ChannelFlowSummary = struct {
    /// The ARN of the channel flow.
    channel_flow_arn: ?[]const u8,

    /// The name of the channel flow.
    name: ?[]const u8,

    /// Information about the processor Lambda functions.
    processors: ?[]const Processor,

    pub const json_field_names = .{
        .channel_flow_arn = "ChannelFlowArn",
        .name = "Name",
        .processors = "Processors",
    };
};
