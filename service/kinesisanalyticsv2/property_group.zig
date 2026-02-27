const aws = @import("aws");

/// Property key-value pairs passed into an application.
pub const PropertyGroup = struct {
    /// Describes the key of an application execution property key-value pair.
    property_group_id: []const u8,

    /// Describes the value of an application execution property key-value pair.
    property_map: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .property_group_id = "PropertyGroupId",
        .property_map = "PropertyMap",
    };
};
