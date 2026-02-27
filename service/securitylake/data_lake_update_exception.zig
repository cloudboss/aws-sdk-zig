/// The details of the last `UpdateDataLake` or `DeleteDataLake`
/// API request which failed.
pub const DataLakeUpdateException = struct {
    /// The reason code for the exception of the last `UpdateDataLake` or
    /// `DeleteDataLake` API request.
    code: ?[]const u8,

    /// The reason for the exception of the last `UpdateDataLake`or
    /// `DeleteDataLake` API request.
    reason: ?[]const u8,

    pub const json_field_names = .{
        .code = "code",
        .reason = "reason",
    };
};
