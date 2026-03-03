const Processor = @import("processor.zig").Processor;

/// The details of a channel flow.
pub const ChannelFlow = struct {
    /// The ARN of the channel flow.
    channel_flow_arn: ?[]const u8 = null,

    /// The time at which the channel flow was created.
    created_timestamp: ?i64 = null,

    /// The time at which a channel flow was updated.
    last_updated_timestamp: ?i64 = null,

    /// The name of the channel flow.
    name: ?[]const u8 = null,

    /// Information about the processor Lambda functions.
    processors: ?[]const Processor = null,

    pub const json_field_names = .{
        .channel_flow_arn = "ChannelFlowArn",
        .created_timestamp = "CreatedTimestamp",
        .last_updated_timestamp = "LastUpdatedTimestamp",
        .name = "Name",
        .processors = "Processors",
    };
};
