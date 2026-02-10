const StatusName = @import("status_name.zig").StatusName;
const StatusType = @import("status_type.zig").StatusType;

/// Describes the instance status.
pub const InstanceStatusDetails = struct {
    /// The time when a status check failed. For an instance that was launched and
    /// impaired,
    /// this is the time when the instance was launched.
    impaired_since: ?i64,

    /// The type of instance status.
    name: ?StatusName,

    /// The status.
    status: ?StatusType,
};
