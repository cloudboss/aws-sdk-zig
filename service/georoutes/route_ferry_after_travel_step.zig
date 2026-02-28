const RouteFerryAfterTravelStepType = @import("route_ferry_after_travel_step_type.zig").RouteFerryAfterTravelStepType;

/// Steps of a leg that must be performed after the travel portion of the leg.
pub const RouteFerryAfterTravelStep = struct {
    /// Duration of the step.
    ///
    /// **Unit**: `seconds`
    duration: i64 = 0,

    /// Brief description of the step in the requested language.
    ///
    /// Only available when the TravelStepType is Default.
    instruction: ?[]const u8,

    /// Type of the step.
    @"type": RouteFerryAfterTravelStepType,

    pub const json_field_names = .{
        .duration = "Duration",
        .instruction = "Instruction",
        .@"type" = "Type",
    };
};
