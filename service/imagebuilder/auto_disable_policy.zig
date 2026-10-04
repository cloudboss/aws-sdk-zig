/// Defines the rules by which an image pipeline is automatically disabled when
/// it fails. By default, if the schedule doesn't include an auto-disable
/// policy, Image Builder disables the pipeline after 5 consecutive failed
/// scheduled
/// builds.
pub const AutoDisablePolicy = struct {
    /// The number of consecutive scheduled image pipeline executions that must fail
    /// before Image Builder
    /// automatically disables the pipeline.
    failure_count: i32,

    pub const json_field_names = .{
        .failure_count = "failureCount",
    };
};
