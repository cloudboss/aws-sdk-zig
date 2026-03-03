const CapacityTaskStatus = @import("capacity_task_status.zig").CapacityTaskStatus;

/// The summary of the capacity task.
pub const CapacityTaskSummary = struct {
    /// The ID of the asset. An Outpost asset can be a single server within an
    /// Outposts rack or an
    /// Outposts server configuration.
    asset_id: ?[]const u8 = null,

    /// The ID of the specified capacity task.
    capacity_task_id: ?[]const u8 = null,

    /// The status of the capacity task.
    capacity_task_status: ?CapacityTaskStatus = null,

    /// The date that the specified capacity task successfully ran.
    completion_date: ?i64 = null,

    /// The date that the specified capacity task was created.
    creation_date: ?i64 = null,

    /// The date that the specified capacity was last modified.
    last_modified_date: ?i64 = null,

    /// The ID of the Amazon Web Services Outposts order of the host associated with
    /// the capacity task.
    order_id: ?[]const u8 = null,

    /// The ID of the Outpost associated with the specified capacity task.
    outpost_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .asset_id = "AssetId",
        .capacity_task_id = "CapacityTaskId",
        .capacity_task_status = "CapacityTaskStatus",
        .completion_date = "CompletionDate",
        .creation_date = "CreationDate",
        .last_modified_date = "LastModifiedDate",
        .order_id = "OrderId",
        .outpost_id = "OutpostId",
    };
};
