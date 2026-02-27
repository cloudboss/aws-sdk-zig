const WaypointOptimizationRestCycles = @import("waypoint_optimization_rest_cycles.zig").WaypointOptimizationRestCycles;
const WaypointOptimizationRestProfile = @import("waypoint_optimization_rest_profile.zig").WaypointOptimizationRestProfile;
const WaypointOptimizationServiceTimeTreatment = @import("waypoint_optimization_service_time_treatment.zig").WaypointOptimizationServiceTimeTreatment;

/// Driver related options.
pub const WaypointOptimizationDriverOptions = struct {
    /// Driver work-rest schedules defined by a short and long cycle. A rest needs
    /// to be taken after the short work duration. The short cycle can be repeated
    /// until you hit the long work duration, at which point the long rest duration
    /// should be taken before restarting.
    rest_cycles: ?WaypointOptimizationRestCycles,

    /// Pre defined rest profiles for a driver schedule. The only currently
    /// supported profile is EU.
    rest_profile: ?WaypointOptimizationRestProfile,

    /// If the service time provided at a waypoint/destination should be considered
    /// as rest or work. This contributes to the total time breakdown returned
    /// within the response.
    treat_service_time_as: ?WaypointOptimizationServiceTimeTreatment,

    pub const json_field_names = .{
        .rest_cycles = "RestCycles",
        .rest_profile = "RestProfile",
        .treat_service_time_as = "TreatServiceTimeAs",
    };
};
