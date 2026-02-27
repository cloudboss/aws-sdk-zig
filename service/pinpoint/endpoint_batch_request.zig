const EndpointBatchItem = @import("endpoint_batch_item.zig").EndpointBatchItem;

/// Specifies a batch of endpoints to create or update and the settings and
/// attributes to set or change for each endpoint.
pub const EndpointBatchRequest = struct {
    /// An array that defines the endpoints to create or update and, for each
    /// endpoint, the property values to set or change. An array can contain a
    /// maximum of 100 items.
    item: []const EndpointBatchItem,

    pub const json_field_names = .{
        .item = "Item",
    };
};
