const GroupKey = @import("group_key.zig").GroupKey;

/// a structure that contains information on the count of resources within a
/// group.
pub const Counts = struct {
    /// The number of resources.
    count: i64 = 0,

    /// The key associated with this group
    group_key: ?GroupKey = null,

    pub const json_field_names = .{
        .count = "count",
        .group_key = "groupKey",
    };
};
