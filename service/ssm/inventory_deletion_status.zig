pub const InventoryDeletionStatus = enum {
    in_progress,
    complete,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .complete = "COMPLETE",
    };
};
