const StatusName = @import("status_name.zig").StatusName;
const StatusType = @import("status_type.zig").StatusType;

/// Describes the attached EBS status check for an instance.
pub const EbsStatusDetails = struct {
    /// The date and time when the attached EBS status check failed.
    impaired_since: ?i64,

    /// The name of the attached EBS status check.
    name: ?StatusName,

    /// The result of the attached EBS status check.
    status: ?StatusType,
};
