const LandingZoneOperationType = @import("landing_zone_operation_type.zig").LandingZoneOperationType;
const LandingZoneOperationStatus = @import("landing_zone_operation_status.zig").LandingZoneOperationStatus;

/// Information about a landing zone operation.
pub const LandingZoneOperationDetail = struct {
    /// The landing zone operation end time.
    end_time: ?i64 = null,

    /// The `operationIdentifier` of the landing zone operation.
    operation_identifier: ?[]const u8 = null,

    /// The landing zone operation type.
    ///
    /// Valid values:
    ///
    /// * `DELETE`: The `DeleteLandingZone` operation.
    /// * `CREATE`: The `CreateLandingZone` operation.
    /// * `UPDATE`: The `UpdateLandingZone` operation.
    /// * `RESET`: The `ResetLandingZone` operation.
    operation_type: ?LandingZoneOperationType = null,

    /// The landing zone operation start time.
    start_time: ?i64 = null,

    /// Valid values:
    ///
    /// * `SUCCEEDED`: The landing zone operation succeeded.
    /// * `IN_PROGRESS`: The landing zone operation is in progress.
    /// * `FAILED`: The landing zone operation failed.
    status: ?LandingZoneOperationStatus = null,

    /// If the operation result is FAILED, this string contains a message explaining
    /// why the operation failed.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .end_time = "endTime",
        .operation_identifier = "operationIdentifier",
        .operation_type = "operationType",
        .start_time = "startTime",
        .status = "status",
        .status_message = "statusMessage",
    };
};
