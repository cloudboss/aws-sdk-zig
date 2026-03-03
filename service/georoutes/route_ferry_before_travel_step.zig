const RouteFerryBeforeTravelStepType = @import("route_ferry_before_travel_step_type.zig").RouteFerryBeforeTravelStepType;

/// Steps of a leg that must be performed before the travel portion of the leg.
pub const RouteFerryBeforeTravelStep = struct {
    /// Duration of the step.
    ///
    /// **Unit**: `seconds`
    duration: i64 = 0,

    /// Brief description of the step in the requested language.
    ///
    /// Only available when the TravelStepType is Default.
    instruction: ?[]const u8 = null,

    /// Type of the step.
    @"type": RouteFerryBeforeTravelStepType,

    pub const json_field_names = .{
        .duration = "Duration",
        .instruction = "Instruction",
        .@"type" = "Type",
    };
};
