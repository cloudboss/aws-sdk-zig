/// List of operational recommendations that did not get included or excluded.
pub const BatchUpdateRecommendationStatusFailedEntry = struct {
    /// An identifier of an entry in this batch that is used to communicate the
    /// result.
    ///
    /// The `entryId`s of a batch request need to be unique within a request.
    entry_id: []const u8,

    /// Indicates the error that occurred while excluding an operational
    /// recommendation.
    error_message: []const u8,

    pub const json_field_names = .{
        .entry_id = "entryId",
        .error_message = "errorMessage",
    };
};
