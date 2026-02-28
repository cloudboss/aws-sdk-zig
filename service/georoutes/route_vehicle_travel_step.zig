const RouteContinueHighwayStepDetails = @import("route_continue_highway_step_details.zig").RouteContinueHighwayStepDetails;
const RouteContinueStepDetails = @import("route_continue_step_details.zig").RouteContinueStepDetails;
const RouteRoad = @import("route_road.zig").RouteRoad;
const RouteEnterHighwayStepDetails = @import("route_enter_highway_step_details.zig").RouteEnterHighwayStepDetails;
const LocalizedString = @import("localized_string.zig").LocalizedString;
const RouteExitStepDetails = @import("route_exit_step_details.zig").RouteExitStepDetails;
const RouteKeepStepDetails = @import("route_keep_step_details.zig").RouteKeepStepDetails;
const RouteRampStepDetails = @import("route_ramp_step_details.zig").RouteRampStepDetails;
const RouteRoundaboutEnterStepDetails = @import("route_roundabout_enter_step_details.zig").RouteRoundaboutEnterStepDetails;
const RouteRoundaboutExitStepDetails = @import("route_roundabout_exit_step_details.zig").RouteRoundaboutExitStepDetails;
const RouteRoundaboutPassStepDetails = @import("route_roundabout_pass_step_details.zig").RouteRoundaboutPassStepDetails;
const RouteSignpost = @import("route_signpost.zig").RouteSignpost;
const RouteTurnStepDetails = @import("route_turn_step_details.zig").RouteTurnStepDetails;
const RouteVehicleTravelStepType = @import("route_vehicle_travel_step_type.zig").RouteVehicleTravelStepType;
const RouteUTurnStepDetails = @import("route_u_turn_step_details.zig").RouteUTurnStepDetails;

/// Steps of a leg that correspond to the travel portion of the leg.
pub const RouteVehicleTravelStep = struct {
    /// Details that are specific to a Continue Highway step.
    continue_highway_step_details: ?RouteContinueHighwayStepDetails,

    /// Details that are specific to a Continue step.
    continue_step_details: ?RouteContinueStepDetails,

    /// Details of the current road.
    current_road: ?RouteRoad,

    /// Distance of the step.
    distance: i64 = 0,

    /// Duration of the step.
    ///
    /// **Unit**: `seconds`
    duration: i64 = 0,

    /// Details that are specific to a Enter Highway step.
    enter_highway_step_details: ?RouteEnterHighwayStepDetails,

    /// Exit number of the road exit, if applicable.
    exit_number: ?[]const LocalizedString,

    /// Details that are specific to a Roundabout Exit step.
    exit_step_details: ?RouteExitStepDetails,

    /// Offset in the leg geometry corresponding to the start of this step.
    geometry_offset: ?i32,

    /// Brief description of the step in the requested language.
    ///
    /// Only available when the TravelStepType is Default.
    instruction: ?[]const u8,

    /// Details that are specific to a Keep step.
    keep_step_details: ?RouteKeepStepDetails,

    /// Details of the next road. See RouteRoad for details of sub-attributes.
    next_road: ?RouteRoad,

    /// Details that are specific to a Ramp step.
    ramp_step_details: ?RouteRampStepDetails,

    /// Details that are specific to a Roundabout Enter step.
    roundabout_enter_step_details: ?RouteRoundaboutEnterStepDetails,

    /// Details that are specific to a Roundabout Exit step.
    roundabout_exit_step_details: ?RouteRoundaboutExitStepDetails,

    /// Details that are specific to a Roundabout Pass step.
    roundabout_pass_step_details: ?RouteRoundaboutPassStepDetails,

    /// Sign post information of the action, applicable only for TurnByTurn steps.
    /// See RouteSignpost for details of sub-attributes.
    signpost: ?RouteSignpost,

    /// Details that are specific to a Turn step.
    turn_step_details: ?RouteTurnStepDetails,

    /// Type of the step.
    @"type": RouteVehicleTravelStepType,

    /// Details that are specific to a Turn step.
    u_turn_step_details: ?RouteUTurnStepDetails,

    pub const json_field_names = .{
        .continue_highway_step_details = "ContinueHighwayStepDetails",
        .continue_step_details = "ContinueStepDetails",
        .current_road = "CurrentRoad",
        .distance = "Distance",
        .duration = "Duration",
        .enter_highway_step_details = "EnterHighwayStepDetails",
        .exit_number = "ExitNumber",
        .exit_step_details = "ExitStepDetails",
        .geometry_offset = "GeometryOffset",
        .instruction = "Instruction",
        .keep_step_details = "KeepStepDetails",
        .next_road = "NextRoad",
        .ramp_step_details = "RampStepDetails",
        .roundabout_enter_step_details = "RoundaboutEnterStepDetails",
        .roundabout_exit_step_details = "RoundaboutExitStepDetails",
        .roundabout_pass_step_details = "RoundaboutPassStepDetails",
        .signpost = "Signpost",
        .turn_step_details = "TurnStepDetails",
        .@"type" = "Type",
        .u_turn_step_details = "UTurnStepDetails",
    };
};
