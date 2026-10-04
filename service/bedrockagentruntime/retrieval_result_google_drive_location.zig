/// The Google Drive location of a retrieval result.
pub const RetrievalResultGoogleDriveLocation = struct {
    /// The Google Drive URL for the data source location.
    url: ?[]const u8 = null,

    pub const json_field_names = .{
        .url = "url",
    };
};
