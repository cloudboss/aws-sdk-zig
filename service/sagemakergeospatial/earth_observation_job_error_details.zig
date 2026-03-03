const EarthObservationJobErrorType = @import("earth_observation_job_error_type.zig").EarthObservationJobErrorType;

/// The structure representing the errors in an EarthObservationJob.
pub const EarthObservationJobErrorDetails = struct {
    /// A detailed message describing the error in an Earth Observation job.
    message: ?[]const u8 = null,

    /// The type of error in an Earth Observation job.
    @"type": ?EarthObservationJobErrorType = null,

    pub const json_field_names = .{
        .message = "Message",
        .@"type" = "Type",
    };
};
