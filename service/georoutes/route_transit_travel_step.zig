const RouteTransitTravelStepType = @import("route_transit_travel_step_type.zig").RouteTransitTravelStepType;

/// A step that must be performed during the travel portion of the leg.
pub const RouteTransitTravelStep = struct {
    /// Distance of the step.
    ///
    /// **Unit**: `meters`
    distance: ?i64 = null,

    /// Duration of the step.
    ///
    /// **Unit**: `seconds`
    duration: i64,

    /// Offset in the leg geometry corresponding to the start of this step.
    geometry_offset: ?i32 = null,

    /// Brief description of the step in the requested language.
    instruction: ?[]const u8 = null,

    /// Type of the step.
    type: RouteTransitTravelStepType,

    pub const json_field_names = .{
        .distance = "Distance",
        .duration = "Duration",
        .geometry_offset = "GeometryOffset",
        .instruction = "Instruction",
        .type = "Type",
    };
};
