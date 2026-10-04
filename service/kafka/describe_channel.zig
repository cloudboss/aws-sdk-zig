const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChannelDestinationType = @import("channel_destination_type.zig").ChannelDestinationType;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const IcebergDestinationConfiguration = @import("iceberg_destination_configuration.zig").IcebergDestinationConfiguration;
const ChannelLoggingInfo = @import("channel_logging_info.zig").ChannelLoggingInfo;
const S3DestinationConfiguration = @import("s3_destination_configuration.zig").S3DestinationConfiguration;
const ChannelStateInfo = @import("channel_state_info.zig").ChannelStateInfo;
const ChannelStatus = @import("channel_status.zig").ChannelStatus;
const TopicConfiguration = @import("topic_configuration.zig").TopicConfiguration;

pub const DescribeChannelInput = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies the channel.
    channel_arn: []const u8,

    /// The Amazon Resource Name (ARN) that uniquely identifies the cluster.
    cluster_arn: []const u8,

    pub const json_field_names = .{
        .channel_arn = "ChannelArn",
        .cluster_arn = "ClusterArn",
    };
};

pub const DescribeChannelOutput = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies the channel.
    channel_arn: []const u8,

    /// The name of the channel.
    channel_name: []const u8,

    /// The Amazon Resource Name (ARN) of the in-flight cluster operation. Returned
    /// only while the channel is in CREATING, UPDATING, or DELETING.
    cluster_operation_arn: ?[]const u8 = null,

    /// The time when the channel was created.
    creation_time: i64,

    /// The type of destination configured for the channel.
    destination_type: ChannelDestinationType,

    /// The encryption configuration applied to the channel.
    encryption_configuration: ?EncryptionConfiguration = null,

    /// The Apache Iceberg destination for the channel, if configured.
    iceberg_destination_configuration: ?IcebergDestinationConfiguration = null,

    /// The destinations to which the channel publishes operational logs.
    logging_info: ?ChannelLoggingInfo = null,

    /// The Amazon S3 destination for the channel, if configured.
    s3_destination_configuration: ?S3DestinationConfiguration = null,

    /// Additional context for the current channel state, populated when the channel
    /// is in FAILED.
    state_info: ?ChannelStateInfo = null,

    /// The current lifecycle state of the channel.
    status: ChannelStatus,

    /// The tags attached to the channel.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The list of topic configurations for the channel.
    topic_configuration_list: ?[]const TopicConfiguration = null,

    pub const json_field_names = .{
        .channel_arn = "ChannelArn",
        .channel_name = "ChannelName",
        .cluster_operation_arn = "ClusterOperationArn",
        .creation_time = "CreationTime",
        .destination_type = "DestinationType",
        .encryption_configuration = "EncryptionConfiguration",
        .iceberg_destination_configuration = "IcebergDestinationConfiguration",
        .logging_info = "LoggingInfo",
        .s3_destination_configuration = "S3DestinationConfiguration",
        .state_info = "StateInfo",
        .status = "Status",
        .tags = "Tags",
        .topic_configuration_list = "TopicConfigurationList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeChannelInput, options: CallOptions) !DescribeChannelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kafka", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeChannelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kafka", "Kafka", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/clusters/");
    try path_buf.appendSlice(allocator, input.cluster_arn);
    try path_buf.appendSlice(allocator, "/channels/");
    try path_buf.appendSlice(allocator, input.channel_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeChannelOutput {
    const result: DescribeChannelOutput = try aws.json.parseJsonObject(
        DescribeChannelOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
