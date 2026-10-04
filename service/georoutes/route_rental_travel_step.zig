const RouteContinueStepDetails = @import("route_continue_step_details.zig").RouteContinueStepDetails;
const RouteExitStepDetails = @import("route_exit_step_details.zig").RouteExitStepDetails;
const RouteKeepStepDetails = @import("route_keep_step_details.zig").RouteKeepStepDetails;
const RouteRampStepDetails = @import("route_ramp_step_details.zig").RouteRampStepDetails;
const RouteRoundaboutEnterStepDetails = @import("route_roundabout_enter_step_details.zig").RouteRoundaboutEnterStepDetails;
const RouteRoundaboutExitStepDetails = @import("route_roundabout_exit_step_details.zig").RouteRoundaboutExitStepDetails;
const RouteRoundaboutPassStepDetails = @import("route_roundabout_pass_step_details.zig").RouteRoundaboutPassStepDetails;
const RouteTurnStepDetails = @import("route_turn_step_details.zig").RouteTurnStepDetails;
const RouteRentalTravelStepType = @import("route_rental_travel_step_type.zig").RouteRentalTravelStepType;
const RouteUTurnStepDetails = @import("route_u_turn_step_details.zig").RouteUTurnStepDetails;

/// A step that must be performed during the travel portion of the leg.
pub const RouteRentalTravelStep = struct {
    continue_step_details: ?RouteContinueStepDetails = null,

    /// Distance of the step.
    ///
    /// **Unit**: `meters`
    distance: ?i64 = null,

    /// Duration of the step.
    ///
    /// **Unit**: `seconds`
    duration: i64,

    exit_step_details: ?RouteExitStepDetails = null,

    /// Offset in the leg geometry corresponding to the start of this step.
    geometry_offset: ?i32 = null,

    /// Brief description of the step in the requested language.
    instruction: ?[]const u8 = null,

    keep_step_details: ?RouteKeepStepDetails = null,

    ramp_step_details: ?RouteRampStepDetails = null,

    roundabout_enter_step_details: ?RouteRoundaboutEnterStepDetails = null,

    roundabout_exit_step_details: ?RouteRoundaboutExitStepDetails = null,

    roundabout_pass_step_details: ?RouteRoundaboutPassStepDetails = null,

    turn_step_details: ?RouteTurnStepDetails = null,

    /// Type of the step.
    @"type": RouteRentalTravelStepType,

    u_turn_step_details: ?RouteUTurnStepDetails = null,

    pub const json_field_names = .{
        .continue_step_details = "ContinueStepDetails",
        .distance = "Distance",
        .duration = "Duration",
        .exit_step_details = "ExitStepDetails",
        .geometry_offset = "GeometryOffset",
        .instruction = "Instruction",
        .keep_step_details = "KeepStepDetails",
        .ramp_step_details = "RampStepDetails",
        .roundabout_enter_step_details = "RoundaboutEnterStepDetails",
        .roundabout_exit_step_details = "RoundaboutExitStepDetails",
        .roundabout_pass_step_details = "RoundaboutPassStepDetails",
        .turn_step_details = "TurnStepDetails",
        .@"type" = "Type",
        .u_turn_step_details = "UTurnStepDetails",
    };
};
