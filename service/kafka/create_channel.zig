const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const IcebergDestinationConfiguration = @import("iceberg_destination_configuration.zig").IcebergDestinationConfiguration;
const ChannelLoggingInfo = @import("channel_logging_info.zig").ChannelLoggingInfo;
const S3DestinationConfiguration = @import("s3_destination_configuration.zig").S3DestinationConfiguration;
const TopicConfiguration = @import("topic_configuration.zig").TopicConfiguration;

pub const CreateChannelInput = struct {
    /// The name of the channel. Must be unique within the cluster.
    channel_name: []const u8,

    /// The Amazon Resource Name (ARN) that uniquely identifies the cluster.
    cluster_arn: []const u8,

    /// The encryption configuration applied to the channel.
    encryption_configuration: ?EncryptionConfiguration = null,

    /// The Apache Iceberg destination for the channel. Mutually exclusive with
    /// s3DestinationConfiguration.
    iceberg_destination_configuration: ?IcebergDestinationConfiguration = null,

    /// The destinations to which the channel publishes operational logs.
    logging_info: ?ChannelLoggingInfo = null,

    /// The Amazon S3 destination for the channel. Mutually exclusive with
    /// icebergDestinationConfiguration.
    s3_destination_configuration: ?S3DestinationConfiguration = null,

    /// The tags attached to the channel.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The list of topic configurations for the channel. Currently exactly one
    /// topic must be specified.
    topic_configuration_list: []const TopicConfiguration,

    pub const json_field_names = .{
        .channel_name = "ChannelName",
        .cluster_arn = "ClusterArn",
        .encryption_configuration = "EncryptionConfiguration",
        .iceberg_destination_configuration = "IcebergDestinationConfiguration",
        .logging_info = "LoggingInfo",
        .s3_destination_configuration = "S3DestinationConfiguration",
        .tags = "Tags",
        .topic_configuration_list = "TopicConfigurationList",
    };
};

pub const CreateChannelOutput = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies the channel.
    channel_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the cluster operation.
    cluster_operation_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel_arn = "ChannelArn",
        .cluster_operation_arn = "ClusterOperationArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateChannelInput, options: CallOptions) !CreateChannelOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateChannelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kafka", "Kafka", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/clusters/");
    try path_buf.appendSlice(allocator, input.cluster_arn);
    try path_buf.appendSlice(allocator, "/channels");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ChannelName\":");
    try aws.json.writeValue(@TypeOf(input.channel_name), input.channel_name, allocator, &body_buf);
    has_prev = true;
    if (input.encryption_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"EncryptionConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.iceberg_destination_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IcebergDestinationConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.logging_info) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LoggingInfo\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.s3_destination_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"S3DestinationConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TopicConfigurationList\":");
    try aws.json.writeValue(@TypeOf(input.topic_configuration_list), input.topic_configuration_list, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateChannelOutput {
    const result: CreateChannelOutput = try aws.json.parseJsonObject(
        CreateChannelOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
