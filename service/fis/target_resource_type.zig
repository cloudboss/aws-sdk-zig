const aws = @import("aws");

const TargetResourceTypeParameter = @import("target_resource_type_parameter.zig").TargetResourceTypeParameter;

/// Describes a resource type.
pub const TargetResourceType = struct {
    /// A description of the resource type.
    description: ?[]const u8 = null,

    /// The parameters for the resource type.
    parameters: ?[]const aws.map.MapEntry(TargetResourceTypeParameter) = null,

    /// The resource type.
    resource_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "description",
        .parameters = "parameters",
        .resource_type = "resourceType",
    };
};
