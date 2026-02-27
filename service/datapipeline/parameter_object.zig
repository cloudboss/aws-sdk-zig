const ParameterAttribute = @import("parameter_attribute.zig").ParameterAttribute;

/// Contains information about a parameter object.
pub const ParameterObject = struct {
    /// The attributes of the parameter object.
    attributes: []const ParameterAttribute,

    /// The ID of the parameter object.
    id: []const u8,

    pub const json_field_names = .{
        .attributes = "attributes",
        .id = "id",
    };
};
