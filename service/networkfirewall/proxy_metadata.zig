/// High-level information about a proxy, returned by operations like create and
/// describe. You can use the information provided in the metadata to retrieve
/// and manage a
/// proxy. You can retrieve all objects for a proxy by calling DescribeProxy.
pub const ProxyMetadata = struct {
    /// The Amazon Resource Name (ARN) of a proxy.
    arn: ?[]const u8,

    /// The descriptive name of the proxy. You can't change the name of a proxy
    /// after you create it.
    name: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .name = "Name",
    };
};
