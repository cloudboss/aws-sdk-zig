const ReadSetExportJobItemStatus = @import("read_set_export_job_item_status.zig").ReadSetExportJobItemStatus;

/// Details about a read set.
pub const ExportReadSetDetail = struct {
    /// The set's ID.
    id: []const u8,

    /// The set's status.
    status: ReadSetExportJobItemStatus,

    /// The set's status message.
    status_message: ?[]const u8,

    pub const json_field_names = .{
        .id = "id",
        .status = "status",
        .status_message = "statusMessage",
    };
};
