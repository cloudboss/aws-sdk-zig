/// The Amazon S3 location for the pointwise model diagnostics for an Amazon
/// Lookout for Equipment model.
pub const ModelDiagnosticsS3OutputConfiguration = struct {
    /// The name of the Amazon S3 bucket where the pointwise model diagnostics are
    /// located. You must be the owner of the Amazon S3 bucket.
    bucket: []const u8,

    /// The Amazon S3 prefix for the location of the pointwise model diagnostics.
    /// The
    /// prefix specifies the folder and evaluation result file name.
    /// (`bucket`).
    ///
    /// When you call `CreateModel` or `UpdateModel`, specify the path
    /// within the bucket that you want Lookout for Equipment to save the model to.
    /// During training, Lookout for Equipment creates the model evaluation model
    /// as a compressed JSON file with the name `model_diagnostics_results.json.gz`.
    ///
    /// When you call `DescribeModel` or `DescribeModelVersion`, `prefix` contains
    /// the file path and filename of the model evaluation file.
    prefix: ?[]const u8,

    pub const json_field_names = .{
        .bucket = "Bucket",
        .prefix = "Prefix",
    };
};
