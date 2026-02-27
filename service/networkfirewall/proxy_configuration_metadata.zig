/// High-level information about a proxy configuration, returned by operations
/// like create and
/// describe. You can use the information provided in the metadata to retrieve
/// and manage a
/// proxy configuration. You can retrieve all objects for a proxy configuration
/// by calling DescribeProxyConfiguration.
pub const ProxyConfigurationMetadata = struct {
    /// The Amazon Resource Name (ARN) of a proxy configuration.
    arn: ?[]const u8,

    /// The descriptive name of the proxy configuration. You can't change the name
    /// of a proxy configuration after you create it.
    name: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .name = "Name",
    };
};
