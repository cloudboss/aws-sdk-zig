const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChannelLoggingUpdateInput = @import("channel_logging_update_input.zig").ChannelLoggingUpdateInput;
const S3DestinationUpdateInput = @import("s3_destination_update_input.zig").S3DestinationUpdateInput;
const S3TablesDestinationUpdateInput = @import("s3_tables_destination_update_input.zig").S3TablesDestinationUpdateInput;
const ChannelDescription = @import("channel_description.zig").ChannelDescription;

pub const UpdateChannelInput = struct {
    /// The Amazon Resource Name (ARN) of the channel to update.
    channel_arn: []const u8,

    /// The updated Amazon CloudWatch Logs configuration for the channel.
    logging_configuration: ?ChannelLoggingUpdateInput = null,

    /// The updated configuration for a general purpose Amazon S3 destination.
    /// Specify this parameter when the channel delivers to a general purpose Amazon
    /// S3 bucket. Only `DataFreshnessInSeconds` can be updated.
    s3_destination_configuration: ?S3DestinationUpdateInput = null,

    /// The updated configuration for a streaming table destination. Specify this
    /// parameter when the channel delivers to streaming tables on Apache Iceberg in
    /// Amazon S3 Tables. Only `DataFreshnessInSeconds` can be updated.
    s3_tables_destination_configuration: ?S3TablesDestinationUpdateInput = null,

    pub const json_field_names = .{
        .channel_arn = "ChannelARN",
        .logging_configuration = "LoggingConfiguration",
        .s3_destination_configuration = "S3DestinationConfiguration",
        .s3_tables_destination_configuration = "S3TablesDestinationConfiguration",
    };
};

pub const UpdateChannelOutput = struct {
    /// The configuration and current status of the channel after the update,
    /// including its ARN, destination configuration, and lifecycle state.
    /// Immediately after the request, the state is `UPDATING`.
    channel_description: ?ChannelDescription = null,

    pub const json_field_names = .{
        .channel_description = "ChannelDescription",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateChannelInput, options: CallOptions) !UpdateChannelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kinesis", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateChannelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesis", "Kinesis", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Kinesis_20131202.UpdateChannel");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateChannelOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateChannelOutput, body, allocator);
}
