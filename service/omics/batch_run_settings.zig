const InlineSetting = @import("inline_setting.zig").InlineSetting;

/// A union type representing per-run configurations for the batch. Specify
/// exactly one of the following members.
pub const BatchRunSettings = union(enum) {
    /// A list of per-run configurations provided inline in the request. Each entry
    /// must include a unique `runSettingId`. Supports up to 100 entries. For
    /// batches with more than 100 runs, use `s3UriSettings`.
    inline_settings: ?[]const InlineSetting,
    /// An Amazon S3 URI pointing to a JSON file containing per-run configurations.
    /// The file must be a JSON array in the same format as `inlineSettings`.
    /// Supports up to 100,000 run configurations. The maximum file size is 6 GB.
    ///
    /// The IAM service role in `roleArn` must have read access to this S3 object.
    /// HealthOmics validates access to the file during the synchronous API call and
    /// records the file's ETag. If the file is modified after submission, the batch
    /// fails.
    s_3_uri_settings: ?[]const u8,

    pub const json_field_names = .{
        .inline_settings = "inlineSettings",
        .s_3_uri_settings = "s3UriSettings",
    };
};
