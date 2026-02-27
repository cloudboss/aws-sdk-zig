const ReferenceItem = @import("reference_item.zig").ReferenceItem;
const SseConfig = @import("sse_config.zig").SseConfig;
const StoreStatus = @import("store_status.zig").StoreStatus;

/// A variant store.
pub const VariantStoreItem = struct {
    /// When the store was created.
    creation_time: i64,

    /// The store's description.
    description: []const u8,

    /// The store's ID.
    id: []const u8,

    /// The store's name.
    name: []const u8,

    /// The store's genome reference.
    reference: ReferenceItem,

    /// The store's server-side encryption (SSE) settings.
    sse_config: SseConfig,

    /// The store's status.
    status: StoreStatus,

    /// The store's status message.
    status_message: []const u8,

    /// The store's ARN.
    store_arn: []const u8,

    /// The store's size in bytes.
    store_size_bytes: i64,

    /// When the store was updated.
    update_time: i64,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .description = "description",
        .id = "id",
        .name = "name",
        .reference = "reference",
        .sse_config = "sseConfig",
        .status = "status",
        .status_message = "statusMessage",
        .store_arn = "storeArn",
        .store_size_bytes = "storeSizeBytes",
        .update_time = "updateTime",
    };
};
