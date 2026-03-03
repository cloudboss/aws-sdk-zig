const ErrorDetail = @import("error_detail.zig").ErrorDetail;
const GroupStatus = @import("group_status.zig").GroupStatus;

/// Provides the details of a group's status.
pub const GroupStatusDetail = struct {
    /// The details of an error associated a group status.
    error_detail: ?ErrorDetail = null,

    /// The Unix timestamp when the Amazon Q Business application was last updated.
    last_updated_at: ?i64 = null,

    /// The status of a group.
    status: ?GroupStatus = null,

    pub const json_field_names = .{
        .error_detail = "errorDetail",
        .last_updated_at = "lastUpdatedAt",
        .status = "status",
    };
};
