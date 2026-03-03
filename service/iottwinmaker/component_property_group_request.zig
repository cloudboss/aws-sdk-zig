const GroupType = @import("group_type.zig").GroupType;
const PropertyGroupUpdateType = @import("property_group_update_type.zig").PropertyGroupUpdateType;

/// The component property group request.
pub const ComponentPropertyGroupRequest = struct {
    /// The group type.
    group_type: ?GroupType = null,

    /// The property names.
    property_names: ?[]const []const u8 = null,

    /// The update type.
    update_type: ?PropertyGroupUpdateType = null,

    pub const json_field_names = .{
        .group_type = "groupType",
        .property_names = "propertyNames",
        .update_type = "updateType",
    };
};
