const RoutePedestrianAfterTravelStepType = @import("route_pedestrian_after_travel_step_type.zig").RoutePedestrianAfterTravelStepType;

/// Steps of a leg that must be performed after the travel portion of the leg.
pub const RoutePedestrianAfterTravelStep = struct {
    /// Duration of the step.
    ///
    /// **Unit**: `seconds`
    duration: i64,

    /// Brief description of the step in the requested language.
    ///
    /// Only available when the TravelStepType is Default.
    instruction: ?[]const u8 = null,

    /// Type of the step.
    type: RoutePedestrianAfterTravelStepType,

    pub const json_field_names = .{
        .duration = "Duration",
        .instruction = "Instruction",
        .type = "Type",
    };
};
