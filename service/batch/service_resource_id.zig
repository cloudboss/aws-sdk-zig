const ServiceResourceIdName = @import("service_resource_id_name.zig").ServiceResourceIdName;

/// The Batch unique identifier.
pub const ServiceResourceId = struct {
    /// The name of the resource identifier.
    name: ServiceResourceIdName,

    /// The value of the resource identifier.
    value: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
