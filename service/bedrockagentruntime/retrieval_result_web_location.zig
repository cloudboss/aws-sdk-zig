/// The web URL/URLs data source location.
pub const RetrievalResultWebLocation = struct {
    /// The web URL/URLs for the data source location.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .url = "url",
    };
};
