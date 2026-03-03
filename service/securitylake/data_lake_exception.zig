/// The details for an Amazon Security Lake exception.
pub const DataLakeException = struct {
    /// The underlying exception of a Security Lake exception.
    exception: ?[]const u8 = null,

    /// The Amazon Web Services Regions where the exception occurred.
    region: ?[]const u8 = null,

    /// List of all remediation steps for a Security Lake exception.
    remediation: ?[]const u8 = null,

    /// This error can occur if you configure the wrong timestamp format, or if the
    /// subset of entries used for validation had errors or missing values.
    timestamp: ?i64 = null,

    pub const json_field_names = .{
        .exception = "exception",
        .region = "region",
        .remediation = "remediation",
        .timestamp = "timestamp",
    };
};
