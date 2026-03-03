const SystemEndpointAttributes = @import("system_endpoint_attributes.zig").SystemEndpointAttributes;

/// The system attributes that are used with the message template.
pub const SystemAttributes = struct {
    /// The CustomerEndpoint attribute.
    customer_endpoint: ?SystemEndpointAttributes = null,

    /// The name of the task.
    name: ?[]const u8 = null,

    /// The SystemEndpoint attribute.
    system_endpoint: ?SystemEndpointAttributes = null,

    pub const json_field_names = .{
        .customer_endpoint = "customerEndpoint",
        .name = "name",
        .system_endpoint = "systemEndpoint",
    };
};
