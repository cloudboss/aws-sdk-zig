const RouteFerryTravelStepType = @import("route_ferry_travel_step_type.zig").RouteFerryTravelStepType;

/// Steps of a leg that must be performed during the travel portion of the leg.
pub const RouteFerryTravelStep = struct {
    /// Distance of the step.
    distance: i64 = 0,

    /// Duration of the step.
    ///
    /// **Unit**: `seconds`
    duration: i64 = 0,

    /// Offset in the leg geometry corresponding to the start of this step.
    geometry_offset: ?i32,

    /// Brief description of the step in the requested language.
    ///
    /// Only available when the TravelStepType is Default.
    instruction: ?[]const u8,

    /// Type of the step.
    @"type": RouteFerryTravelStepType,

    pub const json_field_names = .{
        .distance = "Distance",
        .duration = "Duration",
        .geometry_offset = "GeometryOffset",
        .instruction = "Instruction",
        .@"type" = "Type",
    };
};
