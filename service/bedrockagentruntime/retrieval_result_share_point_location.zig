/// The SharePoint data source location.
pub const RetrievalResultSharePointLocation = struct {
    /// The SharePoint site URL for the data source location.
    url: ?[]const u8,

    pub const json_field_names = .{
        .url = "url",
    };
};
