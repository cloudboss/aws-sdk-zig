/// The redirect behavior for requests
/// to the website.
pub const AwsS3BucketWebsiteConfigurationRedirectTo = struct {
    /// The name of the host to redirect requests to.
    hostname: ?[]const u8,

    /// The protocol to use when redirecting requests. By default, this field uses
    /// the same protocol as the
    /// original request. Valid values are `http` or `https`.
    protocol: ?[]const u8,

    pub const json_field_names = .{
        .hostname = "Hostname",
        .protocol = "Protocol",
    };
};
