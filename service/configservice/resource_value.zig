const ResourceValueType = @import("resource_value_type.zig").ResourceValueType;

/// The dynamic value of the resource.
pub const ResourceValue = struct {
    /// The value is a resource ID.
    value: ResourceValueType,

    pub const json_field_names = .{
        .value = "Value",
    };
};
