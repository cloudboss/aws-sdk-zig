const RouteTransitBeforeTravelStepType = @import("route_transit_before_travel_step_type.zig").RouteTransitBeforeTravelStepType;

/// A step that must be performed before the travel portion of the leg.
pub const RouteTransitBeforeTravelStep = struct {
    /// Duration of the step.
    ///
    /// **Unit**: `seconds`
    duration: i64,

    /// Brief description of the step in the requested language.
    instruction: ?[]const u8 = null,

    /// Type of the step.
    @"type": RouteTransitBeforeTravelStepType,

    pub const json_field_names = .{
        .duration = "Duration",
        .instruction = "Instruction",
        .@"type" = "Type",
    };
};
