/// A configuration for a shuffle option for input data in a channel. If you use
/// `S3Prefix` for `S3DataType`, the results of the S3 key prefix matches are
/// shuffled. If you use `ManifestFile`, the order of the S3 object references
/// in the `ManifestFile` is shuffled. If you use `AugmentedManifestFile`, the
/// order of the JSON lines in the `AugmentedManifestFile` is shuffled. The
/// shuffling order is determined using the `Seed` value.
///
/// For Pipe input mode, when `ShuffleConfig` is specified shuffling is done at
/// the start of every epoch. With large datasets, this ensures that the order
/// of the training data is different for each epoch, and it helps reduce bias
/// and possible overfitting. In a multi-node training job when `ShuffleConfig`
/// is combined with `S3DataDistributionType` of `ShardedByS3Key`, the data is
/// shuffled across nodes so that the content sent to a particular node on the
/// first epoch might be sent to a different node on the second epoch.
pub const ShuffleConfig = struct {
    /// Determines the shuffling order in `ShuffleConfig` value.
    seed: i64,

    pub const json_field_names = .{
        .seed = "Seed",
    };
};
