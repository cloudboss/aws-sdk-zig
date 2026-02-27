/// The segment delivery configuration settings.
pub const SegmentDeliveryConfiguration = struct {
    /// The base URL of the host or path of the segment delivery server that you're
    /// using to serve segments. This is typically a content delivery network (CDN).
    /// The URL can be absolute or relative. To use an absolute URL include the
    /// protocol, such as `https://example.com/some/path`. To use a relative URL
    /// specify the relative path, such as `/some/path*`.
    base_url: ?[]const u8,

    /// A unique identifier used to distinguish between multiple segment delivery
    /// configurations in a source location.
    name: ?[]const u8,

    pub const json_field_names = .{
        .base_url = "BaseUrl",
        .name = "Name",
    };
};
