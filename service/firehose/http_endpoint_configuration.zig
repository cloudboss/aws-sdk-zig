/// Describes the configuration of the HTTP endpoint to which Kinesis Firehose
/// delivers
/// data.
pub const HttpEndpointConfiguration = struct {
    /// The access key required for Kinesis Firehose to authenticate with the HTTP
    /// endpoint
    /// selected as the destination.
    access_key: ?[]const u8,

    /// The name of the HTTP endpoint selected as the destination.
    name: ?[]const u8,

    /// The URL of the HTTP endpoint selected as the destination.
    ///
    /// If you choose an HTTP endpoint as your destination, review and follow the
    /// instructions in the [Appendix - HTTP Endpoint
    /// Delivery Request and Response
    /// Specifications](https://docs.aws.amazon.com/firehose/latest/dev/httpdeliveryrequestresponse.html).
    url: []const u8,

    pub const json_field_names = .{
        .access_key = "AccessKey",
        .name = "Name",
        .url = "Url",
    };
};
