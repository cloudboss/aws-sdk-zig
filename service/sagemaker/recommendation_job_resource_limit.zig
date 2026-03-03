/// Specifies the maximum number of jobs that can run in parallel and the
/// maximum number of jobs that can run.
pub const RecommendationJobResourceLimit = struct {
    /// Defines the maximum number of load tests.
    max_number_of_tests: ?i32 = null,

    /// Defines the maximum number of parallel load tests.
    max_parallel_of_tests: ?i32 = null,

    pub const json_field_names = .{
        .max_number_of_tests = "MaxNumberOfTests",
        .max_parallel_of_tests = "MaxParallelOfTests",
    };
};
