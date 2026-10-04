/// Configuration for metadata to include in recommendation responses.
pub const RecommendationMetadata = struct {
    /// A list of metadata column names from your Items dataset to include in the
    /// recommendation response.
    columns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .columns = "Columns",
    };
};
