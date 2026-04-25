const StreamDeliveryResource = @import("stream_delivery_resource.zig").StreamDeliveryResource;

/// Configuration for streaming memory record data to external resources.
pub const StreamDeliveryResources = struct {
    /// List of stream delivery resource configurations.
    resources: []const StreamDeliveryResource,

    pub const json_field_names = .{
        .resources = "resources",
    };
};
