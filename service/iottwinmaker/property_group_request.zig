const GroupType = @import("group_type.zig").GroupType;

pub const PropertyGroupRequest = struct {
    /// The group type.
    group_type: ?GroupType,

    /// The names of properties.
    property_names: ?[]const []const u8,

    pub const json_field_names = .{
        .group_type = "groupType",
        .property_names = "propertyNames",
    };
};
