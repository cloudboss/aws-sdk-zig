const RouteContinueStepDetails = @import("route_continue_step_details.zig").RouteContinueStepDetails;
const RouteRoad = @import("route_road.zig").RouteRoad;
const LocalizedString = @import("localized_string.zig").LocalizedString;
const RouteKeepStepDetails = @import("route_keep_step_details.zig").RouteKeepStepDetails;
const RouteRoundaboutEnterStepDetails = @import("route_roundabout_enter_step_details.zig").RouteRoundaboutEnterStepDetails;
const RouteRoundaboutExitStepDetails = @import("route_roundabout_exit_step_details.zig").RouteRoundaboutExitStepDetails;
const RouteRoundaboutPassStepDetails = @import("route_roundabout_pass_step_details.zig").RouteRoundaboutPassStepDetails;
const RouteSignpost = @import("route_signpost.zig").RouteSignpost;
const RouteTurnStepDetails = @import("route_turn_step_details.zig").RouteTurnStepDetails;
const RoutePedestrianTravelStepType = @import("route_pedestrian_travel_step_type.zig").RoutePedestrianTravelStepType;

/// Steps of a leg that must be performed during the travel portion of the leg.
pub const RoutePedestrianTravelStep = struct {
    /// Details related to the continue step.
    continue_step_details: ?RouteContinueStepDetails = null,

    /// Details of the current road. See RouteRoad for details of sub-attributes.
    current_road: ?RouteRoad = null,

    /// Distance of the step.
    distance: i64 = 0,

    /// Duration of the step.
    ///
    /// **Unit**: `seconds`
    duration: i64 = 0,

    /// Exit number of the road exit, if applicable.
    exit_number: ?[]const LocalizedString = null,

    /// Offset in the leg geometry corresponding to the start of this step.
    geometry_offset: ?i32 = null,

    /// Brief description of the step in the requested language.
    ///
    /// Only available when the TravelStepType is Default.
    instruction: ?[]const u8 = null,

    /// Details that are specific to a Keep step.
    keep_step_details: ?RouteKeepStepDetails = null,

    /// Details of the next road. See RouteRoad for details of sub-attributes.
    next_road: ?RouteRoad = null,

    /// Details that are specific to a Roundabout Enter step.
    roundabout_enter_step_details: ?RouteRoundaboutEnterStepDetails = null,

    /// Details that are specific to a Roundabout Exit step.
    roundabout_exit_step_details: ?RouteRoundaboutExitStepDetails = null,

    /// Details that are specific to a Roundabout Pass step.
    roundabout_pass_step_details: ?RouteRoundaboutPassStepDetails = null,

    /// Sign post information of the action, applicable only for TurnByTurn steps.
    /// See RouteSignpost for details of sub-attributes.
    signpost: ?RouteSignpost = null,

    /// Details that are specific to a turn step.
    turn_step_details: ?RouteTurnStepDetails = null,

    /// Type of the step.
    @"type": RoutePedestrianTravelStepType,

    pub const json_field_names = .{
        .continue_step_details = "ContinueStepDetails",
        .current_road = "CurrentRoad",
        .distance = "Distance",
        .duration = "Duration",
        .exit_number = "ExitNumber",
        .geometry_offset = "GeometryOffset",
        .instruction = "Instruction",
        .keep_step_details = "KeepStepDetails",
        .next_road = "NextRoad",
        .roundabout_enter_step_details = "RoundaboutEnterStepDetails",
        .roundabout_exit_step_details = "RoundaboutExitStepDetails",
        .roundabout_pass_step_details = "RoundaboutPassStepDetails",
        .signpost = "Signpost",
        .turn_step_details = "TurnStepDetails",
        .@"type" = "Type",
    };
};
