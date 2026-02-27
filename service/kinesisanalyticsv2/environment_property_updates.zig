const PropertyGroup = @import("property_group.zig").PropertyGroup;

/// Describes updates to the execution property groups for a Managed Service for
/// Apache Flink application or a Studio notebook.
pub const EnvironmentPropertyUpdates = struct {
    /// Describes updates to the execution property groups.
    property_groups: []const PropertyGroup,

    pub const json_field_names = .{
        .property_groups = "PropertyGroups",
    };
};
