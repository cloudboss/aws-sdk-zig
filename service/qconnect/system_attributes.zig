const SystemEndpointAttributes = @import("system_endpoint_attributes.zig").SystemEndpointAttributes;

/// The system attributes that are used with the message template.
pub const SystemAttributes = struct {
    /// The CustomerEndpoint attribute.
    customer_endpoint: ?SystemEndpointAttributes,

    /// The name of the task.
    name: ?[]const u8,

    /// The SystemEndpoint attribute.
    system_endpoint: ?SystemEndpointAttributes,

    pub const json_field_names = .{
        .customer_endpoint = "customerEndpoint",
        .name = "name",
        .system_endpoint = "systemEndpoint",
    };
};
