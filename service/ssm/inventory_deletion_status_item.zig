const InventoryDeletionSummary = @import("inventory_deletion_summary.zig").InventoryDeletionSummary;
const InventoryDeletionStatus = @import("inventory_deletion_status.zig").InventoryDeletionStatus;

/// Status information returned by the `DeleteInventory` operation.
pub const InventoryDeletionStatusItem = struct {
    /// The deletion ID returned by the `DeleteInventory` operation.
    deletion_id: ?[]const u8,

    /// The UTC timestamp when the delete operation started.
    deletion_start_time: ?i64,

    /// Information about the delete operation. For more information about this
    /// summary, see [Understanding the delete inventory
    /// summary](https://docs.aws.amazon.com/systems-manager/latest/userguide/inventory-custom.html#delete-custom-inventory) in the
    /// *Amazon Web Services Systems Manager User Guide*.
    deletion_summary: ?InventoryDeletionSummary,

    /// The status of the operation. Possible values are InProgress and Complete.
    last_status: ?InventoryDeletionStatus,

    /// Information about the status.
    last_status_message: ?[]const u8,

    /// The UTC timestamp of when the last status report.
    last_status_update_time: ?i64,

    /// The name of the inventory data type.
    type_name: ?[]const u8,

    pub const json_field_names = .{
        .deletion_id = "DeletionId",
        .deletion_start_time = "DeletionStartTime",
        .deletion_summary = "DeletionSummary",
        .last_status = "LastStatus",
        .last_status_message = "LastStatusMessage",
        .last_status_update_time = "LastStatusUpdateTime",
        .type_name = "TypeName",
    };
};
