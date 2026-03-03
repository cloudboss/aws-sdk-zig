const LandingZoneOperationType = @import("landing_zone_operation_type.zig").LandingZoneOperationType;
const LandingZoneOperationStatus = @import("landing_zone_operation_status.zig").LandingZoneOperationStatus;

/// Returns a summary of information about a landing zone operation.
pub const LandingZoneOperationSummary = struct {
    /// The `operationIdentifier` of the landing zone operation.
    operation_identifier: ?[]const u8 = null,

    /// The type of the landing zone operation.
    operation_type: ?LandingZoneOperationType = null,

    /// The status of the landing zone operation.
    status: ?LandingZoneOperationStatus = null,

    pub const json_field_names = .{
        .operation_identifier = "operationIdentifier",
        .operation_type = "operationType",
        .status = "status",
    };
};
