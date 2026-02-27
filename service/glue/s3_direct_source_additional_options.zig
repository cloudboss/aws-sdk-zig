/// Specifies additional connection options for the Amazon S3 data store.
pub const S3DirectSourceAdditionalOptions = struct {
    /// Sets the upper limit for the target number of files that will be processed.
    bounded_files: ?i64,

    /// Sets the upper limit for the target size of the dataset in bytes that will
    /// be processed.
    bounded_size: ?i64,

    /// Sets option to enable a sample path.
    enable_sample_path: ?bool,

    /// If enabled, specifies the sample path.
    sample_path: ?[]const u8,

    pub const json_field_names = .{
        .bounded_files = "BoundedFiles",
        .bounded_size = "BoundedSize",
        .enable_sample_path = "EnableSamplePath",
        .sample_path = "SamplePath",
    };
};
