const IntegerParameterConfig = @import("integer_parameter_config.zig").IntegerParameterConfig;

/// The pod garbage collection controller version configuration.
pub const PodGcControllerVersionConfig = struct {
    /// The terminated pod garbage collection threshold configuration with default
    /// value and constraints.
    terminated_pod_gc_threshold: ?IntegerParameterConfig = null,

    pub const json_field_names = .{
        .terminated_pod_gc_threshold = "terminatedPodGcThreshold",
    };
};
