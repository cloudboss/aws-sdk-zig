pub const ListStreamSessionsRequest = struct {
    /// Channel ARN used to filter the list.
    channel_arn: []const u8,

    /// Maximum number of streams to return. Default: 100.
    max_results: ?i32 = null,

    /// The first stream to retrieve. This is used for pagination; see the
    /// `nextToken` response field.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel_arn = "channelArn",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};
