/// Defines the rules by which an image pipeline is automatically disabled when
/// it fails.
pub const AutoDisablePolicy = struct {
    /// The number of consecutive scheduled image pipeline executions that must fail
    /// before Image Builder
    /// automatically disables the pipeline.
    failure_count: i32,

    pub const json_field_names = .{
        .failure_count = "failureCount",
    };
};
