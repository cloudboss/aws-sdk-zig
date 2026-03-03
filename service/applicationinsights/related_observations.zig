const Observation = @import("observation.zig").Observation;

/// Describes observations related to the problem.
pub const RelatedObservations = struct {
    /// The list of observations related to the problem.
    observation_list: ?[]const Observation = null,

    pub const json_field_names = .{
        .observation_list = "ObservationList",
    };
};
