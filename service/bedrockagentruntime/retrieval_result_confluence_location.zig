/// The Confluence data source location.
pub const RetrievalResultConfluenceLocation = struct {
    /// The Confluence host URL for the data source location.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .url = "url",
    };
};
