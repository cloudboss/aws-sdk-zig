const VehicleState = @import("vehicle_state.zig").VehicleState;

/// Information about a campaign associated with a vehicle.
pub const VehicleStatus = struct {
    /// The name of a campaign.
    campaign_name: ?[]const u8 = null,

    /// The status of a campaign, which can be one of the following:
    ///
    /// * `CREATED` - The campaign exists but is not yet approved.
    ///
    /// * `READY` - The campaign is approved but has not been deployed to the
    ///   vehicle. Data has not arrived at the vehicle yet.
    ///
    /// * `HEALTHY` - The campaign is deployed to the vehicle.
    ///
    /// * `SUSPENDED` - The campaign is suspended and data collection is paused.
    ///
    /// * `DELETING` - The campaign is being removed from the vehicle.
    ///
    /// * `READY_FOR_CHECKIN` - The campaign is approved and waiting for vehicle
    ///   check-in before deployment.
    status: ?VehicleState = null,

    /// The unique ID of the vehicle.
    vehicle_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .campaign_name = "campaignName",
        .status = "status",
        .vehicle_name = "vehicleName",
    };
};
