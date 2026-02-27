const MappingType = @import("mapping_type.zig").MappingType;

/// A structure that defines filtering criteria for the ListControlMappings
/// operation. You can use this filter to narrow down the list of control
/// mappings based on control ARNs, common control ARNs, or mapping types.
pub const ControlMappingFilter = struct {
    /// A list of common control ARNs to filter the mappings. When specified, only
    /// mappings associated with these common controls are returned.
    common_control_arns: ?[]const []const u8,

    /// A list of control ARNs to filter the mappings. When specified, only mappings
    /// associated with these controls are returned.
    control_arns: ?[]const []const u8,

    /// A list of mapping types to filter the mappings. When specified, only
    /// mappings of these types are returned.
    mapping_types: ?[]const MappingType,

    pub const json_field_names = .{
        .common_control_arns = "CommonControlArns",
        .control_arns = "ControlArns",
        .mapping_types = "MappingTypes",
    };
};
