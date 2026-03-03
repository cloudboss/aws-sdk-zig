const PropertyGroup = @import("property_group.zig").PropertyGroup;

/// Describes the execution properties for an Apache Flink runtime.
pub const EnvironmentPropertyDescriptions = struct {
    /// Describes the execution property groups.
    property_group_descriptions: ?[]const PropertyGroup = null,

    pub const json_field_names = .{
        .property_group_descriptions = "PropertyGroupDescriptions",
    };
};
