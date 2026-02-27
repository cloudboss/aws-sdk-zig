const Mapping = @import("mapping.zig").Mapping;
const MappingType = @import("mapping_type.zig").MappingType;

/// A structure that contains information about a control mapping, including the
/// control ARN, mapping type, and mapping details.
pub const ControlMapping = struct {
    /// The Amazon Resource Name (ARN) that identifies the control in the mapping.
    control_arn: []const u8,

    /// The details of the mapping relationship, for example, containing framework,
    /// common control, or related control information.
    mapping: Mapping,

    /// The type of mapping relationship between the control and other entities.
    mapping_type: MappingType,

    pub const json_field_names = .{
        .control_arn = "ControlArn",
        .mapping = "Mapping",
        .mapping_type = "MappingType",
    };
};
