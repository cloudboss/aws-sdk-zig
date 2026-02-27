const GroupName = @import("group_name.zig").GroupName;

/// The object containing information about distinct imports or groups for
/// Strategy Recommendations.
pub const Group = struct {
    /// The key of the specific import group.
    name: ?GroupName,

    /// The value of the specific import group.
    value: ?[]const u8,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
