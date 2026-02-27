const PropertyGroup = @import("property_group.zig").PropertyGroup;

/// Describes execution properties for a Managed Service for Apache Flink
/// application.
pub const EnvironmentProperties = struct {
    /// Describes the execution property groups.
    property_groups: []const PropertyGroup,

    pub const json_field_names = .{
        .property_groups = "PropertyGroups",
    };
};
