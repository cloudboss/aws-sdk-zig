const RouteTransitAfterTravelStepType = @import("route_transit_after_travel_step_type.zig").RouteTransitAfterTravelStepType;

/// A step that must be performed after the travel portion of the leg.
pub const RouteTransitAfterTravelStep = struct {
    /// Duration of the step.
    ///
    /// **Unit**: `seconds`
    duration: i64,

    /// Brief description of the step in the requested language.
    instruction: ?[]const u8 = null,

    /// Type of the step.
    type: RouteTransitAfterTravelStepType,

    pub const json_field_names = .{
        .duration = "Duration",
        .instruction = "Instruction",
        .type = "Type",
    };
};
