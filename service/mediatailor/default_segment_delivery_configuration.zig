/// The optional configuration for a server that serves segments. Use this if
/// you want the segment delivery server to be different from the source
/// location server. For example, you can configure your source location server
/// to be an origination server, such as MediaPackage, and the segment delivery
/// server to be a content delivery network (CDN), such as CloudFront. If you
/// don't specify a segment delivery server, then the source location server is
/// used.
pub const DefaultSegmentDeliveryConfiguration = struct {
    /// The hostname of the server that will be used to serve segments. This string
    /// must include the protocol, such as **https://**.
    base_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .base_url = "BaseUrl",
    };
};
