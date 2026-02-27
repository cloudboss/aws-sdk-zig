const GroupType = @import("group_type.zig").GroupType;

/// The property group response
pub const PropertyGroupResponse = struct {
    /// The group types.
    group_type: GroupType,

    /// A Boolean value that specifies whether the property group is inherited from
    /// a parent
    /// entity
    is_inherited: bool,

    /// The names of properties.
    property_names: []const []const u8,

    pub const json_field_names = .{
        .group_type = "groupType",
        .is_inherited = "isInherited",
        .property_names = "propertyNames",
    };
};
