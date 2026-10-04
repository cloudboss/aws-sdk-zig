/// Configuration parameters used to update the Channel.
pub const UpdateChannelRequest = struct {
    /// A short text description of the Channel.
    description: ?[]const u8 = null,

    /// The ID of the Channel to update.
    id: []const u8,

    pub const json_field_names = .{
        .description = "Description",
        .id = "Id",
    };
};
