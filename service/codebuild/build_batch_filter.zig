const StatusType = @import("status_type.zig").StatusType;

/// Specifies filters when retrieving batch builds.
pub const BuildBatchFilter = struct {
    /// The status of the batch builds to retrieve. Only batch builds that have this
    /// status will
    /// be retrieved.
    status: ?StatusType = null,

    pub const json_field_names = .{
        .status = "status",
    };
};
