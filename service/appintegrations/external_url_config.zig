/// The external URL source for the application.
pub const ExternalUrlConfig = struct {
    /// The URL to access the application.
    access_url: []const u8,

    /// Additional URLs to allow list if different than the access URL.
    approved_origins: ?[]const []const u8,

    pub const json_field_names = .{
        .access_url = "AccessUrl",
        .approved_origins = "ApprovedOrigins",
    };
};
