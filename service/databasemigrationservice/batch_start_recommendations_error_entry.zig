/// Provides information about the errors that occurred during the analysis of
/// the source
/// database.
pub const BatchStartRecommendationsErrorEntry = struct {
    /// The code of an error that occurred during the analysis of the source
    /// database.
    code: ?[]const u8,

    /// The identifier of the source database.
    database_id: ?[]const u8,

    /// The information about the error.
    message: ?[]const u8,

    pub const json_field_names = .{
        .code = "Code",
        .database_id = "DatabaseId",
        .message = "Message",
    };
};
