const Channel = @import("channel.zig").Channel;

pub const ListChannelsResponse = struct {
    /// A list of Channel records.
    channels: ?[]const Channel = null,

    /// A token that can be used to resume pagination from the end of the
    /// collection.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .channels = "Channels",
        .next_token = "NextToken",
    };
};
