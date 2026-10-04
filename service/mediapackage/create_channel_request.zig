const aws = @import("aws");

/// A new Channel configuration.
pub const CreateChannelRequest = struct {
    /// A short text description of the Channel.
    description: ?[]const u8 = null,

    /// The ID of the Channel. The ID must be unique within the region and it
    /// cannot be changed after a Channel is created.
    id: []const u8,

    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .description = "Description",
        .id = "Id",
        .tags = "Tags",
    };
};
