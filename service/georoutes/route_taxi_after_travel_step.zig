const RouteTaxiAfterTravelStepType = @import("route_taxi_after_travel_step_type.zig").RouteTaxiAfterTravelStepType;

/// A step that must be performed after the travel portion of the leg.
pub const RouteTaxiAfterTravelStep = struct {
    /// Duration of the step.
    ///
    /// **Unit**: `seconds`
    duration: i64,

    /// Brief description of the step in the requested language.
    instruction: ?[]const u8 = null,

    /// Type of the step.
    type: RouteTaxiAfterTravelStepType,

    pub const json_field_names = .{
        .duration = "Duration",
        .instruction = "Instruction",
        .type = "Type",
    };
};
