/// Contains an image that is uploaded to IoT SiteWise and available at a URL.
pub const ImageLocation = struct {
    /// The ID of the image.
    id: []const u8,

    /// The URL where the image is available. The URL is valid for 15 minutes so
    /// that you can view
    /// and download the image
    url: []const u8,

    pub const json_field_names = .{
        .id = "id",
        .url = "url",
    };
};
