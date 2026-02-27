/// Provides processing statistics for a classification job.
pub const Statistics = struct {
    /// The approximate number of objects that the job has yet to process during its
    /// current run.
    approximate_number_of_objects_to_process: ?f64,

    /// The number of times that the job has run.
    number_of_runs: ?f64,

    pub const json_field_names = .{
        .approximate_number_of_objects_to_process = "approximateNumberOfObjectsToProcess",
        .number_of_runs = "numberOfRuns",
    };
};
