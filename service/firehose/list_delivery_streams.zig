const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeliveryStreamType = @import("delivery_stream_type.zig").DeliveryStreamType;

pub const ListDeliveryStreamsInput = struct {
    /// The Firehose stream type. This can be one of the following values:
    ///
    /// * `DirectPut`: Provider applications access the Firehose stream
    /// directly.
    ///
    /// * `KinesisStreamAsSource`: The Firehose stream uses a Kinesis data
    /// stream as a source.
    ///
    /// This parameter is optional. If this parameter is omitted, Firehose streams
    /// of all
    /// types are returned.
    delivery_stream_type: ?DeliveryStreamType = null,

    /// The list of Firehose streams returned by this call to
    /// `ListDeliveryStreams` will start with the Firehose stream whose name comes
    /// alphabetically immediately after the name you specify in
    /// `ExclusiveStartDeliveryStreamName`.
    exclusive_start_delivery_stream_name: ?[]const u8 = null,

    /// The maximum number of Firehose streams to list. The default value is 10.
    limit: ?i32 = null,

    pub const json_field_names = .{
        .delivery_stream_type = "DeliveryStreamType",
        .exclusive_start_delivery_stream_name = "ExclusiveStartDeliveryStreamName",
        .limit = "Limit",
    };
};

pub const ListDeliveryStreamsOutput = struct {
    /// The names of the Firehose streams.
    delivery_stream_names: ?[]const []const u8 = null,

    /// Indicates whether there are more Firehose streams available to list.
    has_more_delivery_streams: bool,

    pub const json_field_names = .{
        .delivery_stream_names = "DeliveryStreamNames",
        .has_more_delivery_streams = "HasMoreDeliveryStreams",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDeliveryStreamsInput, options: CallOptions) !ListDeliveryStreamsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "firehose", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDeliveryStreamsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("firehose", "Firehose", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Firehose_20150804.ListDeliveryStreams");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDeliveryStreamsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListDeliveryStreamsOutput, body, allocator);
}
