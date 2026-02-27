const EstimatedResourceSize = @import("estimated_resource_size.zig").EstimatedResourceSize;

/// Statistics information about the channel.
pub const ChannelStatistics = struct {
    /// The estimated size of the channel.
    size: ?EstimatedResourceSize,

    pub const json_field_names = .{
        .size = "size",
    };
};
