const aws = @import("aws");

const Status = @import("status.zig").Status;
const StatusType = @import("status_type.zig").StatusType;

/// A summarized description of the status.
pub const StatusSummary = struct {
    /// The datetime stamp when the status was last updated.
    last_updated_at: i64,

    /// The current status.
    status: ?Status,

    /// Details about the status.
    status_details: ?[]const aws.map.StringMapEntry,

    /// When applicable, returns an informational message relevant to the current
    /// status
    /// and status type of the status summary object. We don't recommend
    /// implementing
    /// parsing logic around this value since the messages returned can vary in
    /// format.
    status_message: ?[]const u8,

    /// The type of a status summary.
    status_type: StatusType,

    pub const json_field_names = .{
        .last_updated_at = "LastUpdatedAt",
        .status = "Status",
        .status_details = "StatusDetails",
        .status_message = "StatusMessage",
        .status_type = "StatusType",
    };
};
