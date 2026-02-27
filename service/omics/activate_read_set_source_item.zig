const ReadSetActivationJobItemStatus = @import("read_set_activation_job_item_status.zig").ReadSetActivationJobItemStatus;

/// A source for a read set activation job.
pub const ActivateReadSetSourceItem = struct {
    /// The source's read set ID.
    read_set_id: []const u8,

    /// The source's status.
    status: ReadSetActivationJobItemStatus,

    /// The source's status message.
    status_message: ?[]const u8,

    pub const json_field_names = .{
        .read_set_id = "readSetId",
        .status = "status",
        .status_message = "statusMessage",
    };
};
