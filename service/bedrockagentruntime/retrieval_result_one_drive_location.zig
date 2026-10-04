/// The Microsoft OneDrive location of a retrieval result.
pub const RetrievalResultOneDriveLocation = struct {
    /// The OneDrive URL for the data source location.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .url = "url",
    };
};
