pub const GetStreamSessionRequest = struct {
    /// ARN of the channel resource
    channel_arn: []const u8,

    /// Unique identifier for a live or previously live stream in the specified
    /// channel. If no
    /// `streamId` is provided, this returns the most recent stream session for the
    /// channel, if it exists.
    stream_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel_arn = "channelArn",
        .stream_id = "streamId",
    };
};
