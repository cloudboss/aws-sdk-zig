/// (Amazon SQS only) The scaling configuration for the event source. To remove
/// the configuration, pass an empty value.
pub const ScalingConfig = struct {
    /// Limits the number of concurrent instances that the Amazon SQS event source
    /// can invoke.
    maximum_concurrency: ?i32,

    pub const json_field_names = .{
        .maximum_concurrency = "MaximumConcurrency",
    };
};
