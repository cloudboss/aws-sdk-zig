const LinkedChannelType = @import("linked_channel_type.zig").LinkedChannelType;

/// Settings for a primary (leader) channel in a linked pair
pub const PrimaryChannelSettings = struct {
    /// Specifies this as a primary channel
    linked_channel_type: ?LinkedChannelType = null,

    pub const json_field_names = .{
        .linked_channel_type = "LinkedChannelType",
    };
};
