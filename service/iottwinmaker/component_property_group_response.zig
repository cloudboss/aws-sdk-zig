const GroupType = @import("group_type.zig").GroupType;

/// The component property group response.
pub const ComponentPropertyGroupResponse = struct {
    /// The group type.
    group_type: GroupType,

    /// A Boolean value that specifies whether the property group is inherited from
    /// a parent
    /// entity
    is_inherited: bool,

    /// The names of properties
    property_names: []const []const u8,

    pub const json_field_names = .{
        .group_type = "groupType",
        .is_inherited = "isInherited",
        .property_names = "propertyNames",
    };
};
