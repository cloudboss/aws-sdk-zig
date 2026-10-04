const ChannelListConfiguration = @import("channel_list_configuration.zig").ChannelListConfiguration;

pub const ListChannelsResponse = struct {
    /// The objects being returned.
    items: ?[]const ChannelListConfiguration = null,

    /// The pagination token from the GET list request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "Items",
        .next_token = "NextToken",
    };
};
