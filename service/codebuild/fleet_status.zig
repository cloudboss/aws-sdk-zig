const FleetContextCode = @import("fleet_context_code.zig").FleetContextCode;
const FleetStatusCode = @import("fleet_status_code.zig").FleetStatusCode;

/// The status of the compute fleet.
pub const FleetStatus = struct {
    /// Additional information about a compute fleet. Valid values include:
    ///
    /// * `CREATE_FAILED`: The compute fleet has failed to create.
    ///
    /// * `UPDATE_FAILED`: The compute fleet has failed to update.
    context: ?FleetContextCode,

    /// A message associated with the status of a compute fleet.
    message: ?[]const u8,

    /// The status code of the compute fleet. Valid values include:
    ///
    /// * `CREATING`: The compute fleet is being created.
    ///
    /// * `UPDATING`: The compute fleet is being updated.
    ///
    /// * `ROTATING`: The compute fleet is being rotated.
    ///
    /// * `PENDING_DELETION`: The compute fleet is pending deletion.
    ///
    /// * `DELETING`: The compute fleet is being deleted.
    ///
    /// * `CREATE_FAILED`: The compute fleet has failed to create.
    ///
    /// * `UPDATE_ROLLBACK_FAILED`: The compute fleet has failed to update and could
    ///   not rollback to previous state.
    ///
    /// * `ACTIVE`: The compute fleet has succeeded and is active.
    status_code: ?FleetStatusCode,

    pub const json_field_names = .{
        .context = "context",
        .message = "message",
        .status_code = "statusCode",
    };
};
