const FleetStateCode = @import("fleet_state_code.zig").FleetStateCode;

/// Describes an EC2 Fleet that was successfully deleted.
pub const DeleteFleetSuccessItem = struct {
    /// The current state of the EC2 Fleet.
    current_fleet_state: ?FleetStateCode = null,

    /// The ID of the EC2 Fleet.
    fleet_id: ?[]const u8 = null,

    /// The previous state of the EC2 Fleet.
    previous_fleet_state: ?FleetStateCode = null,
};
