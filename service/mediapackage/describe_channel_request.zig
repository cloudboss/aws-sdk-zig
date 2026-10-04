pub const DescribeChannelRequest = struct {
    /// The ID of a Channel.
    id: []const u8,

    pub const json_field_names = .{
        .id = "Id",
    };
};
