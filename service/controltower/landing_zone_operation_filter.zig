const LandingZoneOperationStatus = @import("landing_zone_operation_status.zig").LandingZoneOperationStatus;
const LandingZoneOperationType = @import("landing_zone_operation_type.zig").LandingZoneOperationType;

/// A filter object that lets you call `ListLandingZoneOperations` with a
/// specific filter.
pub const LandingZoneOperationFilter = struct {
    /// The statuses of the set of landing zone operations selected by the filter.
    statuses: ?[]const LandingZoneOperationStatus = null,

    /// The set of landing zone operation types selected by the filter.
    types: ?[]const LandingZoneOperationType = null,

    pub const json_field_names = .{
        .statuses = "statuses",
        .types = "types",
    };
};
