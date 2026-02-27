/// Contains summary statistics about a test case execution.
pub const ObservationSummary = struct {
    /// The number of observations that failed during execution.
    observations_failed: ?i32,

    /// The number of observations that passed during execution.
    observations_passed: ?i32,

    /// The total number of observations in the test case.
    total_observations: ?i32,

    pub const json_field_names = .{
        .observations_failed = "ObservationsFailed",
        .observations_passed = "ObservationsPassed",
        .total_observations = "TotalObservations",
    };
};
