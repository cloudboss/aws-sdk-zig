/// Describes the number of in-application streams to create for a given
/// streaming source. For information about parallelism,
/// see [Configuring Application
/// Input](https://docs.aws.amazon.com/kinesisanalytics/latest/dev/how-it-works-input.html).
pub const InputParallelism = struct {
    /// Number of in-application streams to create.
    /// For more information, see
    /// [Limits](https://docs.aws.amazon.com/kinesisanalytics/latest/dev/limits.html).
    count: ?i32 = null,

    pub const json_field_names = .{
        .count = "Count",
    };
};
