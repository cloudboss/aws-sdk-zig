/// An object that contains information on the error that caused the snapshot
/// job to fail.
///
/// For more information, see [DescribeDashboardSnapshotJobResult
/// API](https://docs.aws.amazon.com/quicksight/latest/APIReference/API_DescribeDashboardSnapshotJobResult.html).
pub const SnapshotJobErrorInfo = struct {
    /// The error message.
    error_message: ?[]const u8 = null,

    /// The error type.
    error_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_message = "ErrorMessage",
        .error_type = "ErrorType",
    };
};
