const Instance = @import("instance.zig").Instance;

/// The details about the instance.
pub const InstanceSummary = struct {
    /// A structure containing details about the instance.
    instance: ?Instance = null,

    /// When the instance summary was last updated.
    last_updated_at: ?i64 = null,

    pub const json_field_names = .{
        .instance = "instance",
        .last_updated_at = "lastUpdatedAt",
    };
};
