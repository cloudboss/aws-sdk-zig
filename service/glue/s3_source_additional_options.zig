/// Specifies additional connection options for the Amazon S3 data store.
pub const S3SourceAdditionalOptions = struct {
    /// Sets the upper limit for the target number of files that will be processed.
    bounded_files: ?i64 = null,

    /// Sets the upper limit for the target size of the dataset in bytes that will
    /// be processed.
    bounded_size: ?i64 = null,

    pub const json_field_names = .{
        .bounded_files = "BoundedFiles",
        .bounded_size = "BoundedSize",
    };
};
