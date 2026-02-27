const ResourceAction = @import("resource_action.zig").ResourceAction;
const StatusDetails = @import("status_details.zig").StatusDetails;
const ErrorDetail = @import("error_detail.zig").ErrorDetail;
const ResourceState = @import("resource_state.zig").ResourceState;

/// A structure containing information about the state of an asynchronous change
/// to a table.
pub const TableStatus = struct {
    /// Indicates which action was called on the table, currently only `CREATE` or
    /// `UPDATE`.
    action: ?ResourceAction,

    /// A `StatusDetails` object with information about the requested change.
    details: ?*StatusDetails = null,

    /// An error that will only appear when the state is "FAILED". This is a parent
    /// level exception message, there may be different `Error`s for each dialect.
    @"error": ?ErrorDetail,

    /// The ARN of the user who requested the asynchronous change.
    requested_by: ?[]const u8,

    /// An ISO 8601 formatted date string indicating the time that the change was
    /// initiated.
    request_time: ?i64,

    /// A generic status for the change in progress, such as QUEUED, IN_PROGRESS,
    /// SUCCESS, or FAILED.
    state: ?ResourceState,

    /// The ARN of the user to last manually alter the asynchronous change
    /// (requesting cancellation, etc).
    updated_by: ?[]const u8,

    /// An ISO 8601 formatted date string indicating the time that the state was
    /// last updated.
    update_time: ?i64,

    pub const json_field_names = .{
        .action = "Action",
        .details = "Details",
        .@"error" = "Error",
        .requested_by = "RequestedBy",
        .request_time = "RequestTime",
        .state = "State",
        .updated_by = "UpdatedBy",
        .update_time = "UpdateTime",
    };
};
