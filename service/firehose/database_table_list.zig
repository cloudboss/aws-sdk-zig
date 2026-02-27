/// The structure used to configure the list of table patterns in source
/// database endpoint
/// for Firehose to read from.
///
/// Amazon Data Firehose is in preview release and is subject to change.
pub const DatabaseTableList = struct {
    /// The list of table patterns in source database endpoint to be excluded for
    /// Firehose to
    /// read from.
    ///
    /// Amazon Data Firehose is in preview release and is subject to change.
    exclude: ?[]const []const u8,

    /// The list of table patterns in source database endpoint to be included for
    /// Firehose to
    /// read from.
    ///
    /// Amazon Data Firehose is in preview release and is subject to change.
    include: ?[]const []const u8,

    pub const json_field_names = .{
        .exclude = "Exclude",
        .include = "Include",
    };
};
