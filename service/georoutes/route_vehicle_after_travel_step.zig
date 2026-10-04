const RouteChargeStepDetails = @import("route_charge_step_details.zig").RouteChargeStepDetails;
const RouteVehicleAfterTravelStepType = @import("route_vehicle_after_travel_step_type.zig").RouteVehicleAfterTravelStepType;

/// Steps of a leg that must be performed after the travel portion of the leg.
pub const RouteVehicleAfterTravelStep = struct {
    /// Details that are specific to a Charge step.
    ///
    /// **Unit**: `KwH `
    charge_step_details: ?RouteChargeStepDetails = null,

    /// Duration of the step.
    ///
    /// **Unit**: `seconds`
    duration: i64,

    /// Brief description of the step in the requested language.
    ///
    /// Only available when the TravelStepType is Default.
    instruction: ?[]const u8 = null,

    /// Type of the step.
    @"type": RouteVehicleAfterTravelStepType,

    pub const json_field_names = .{
        .charge_step_details = "ChargeStepDetails",
        .duration = "Duration",
        .instruction = "Instruction",
        .@"type" = "Type",
    };
};
