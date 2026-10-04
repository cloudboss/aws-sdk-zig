const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StreamModeDetails = @import("stream_mode_details.zig").StreamModeDetails;

pub const CreateStreamInput = struct {
    /// The maximum record size of a single record in kibibyte (KiB) that you can
    /// write to, and read from a stream.
    max_record_size_in_ki_b: ?i32 = null,

    /// The number of shards that the stream will use. The throughput of the stream
    /// is a
    /// function of the number of shards; more shards are required for greater
    /// provisioned
    /// throughput.
    shard_count: ?i32 = null,

    /// Indicates the capacity mode of the data stream. Currently, in Kinesis Data
    /// Streams,
    /// you can choose between an **on-demand** capacity mode and a
    /// **provisioned** capacity mode for your data
    /// streams.
    stream_mode_details: ?StreamModeDetails = null,

    /// A name to identify the stream. The stream name is scoped to the Amazon Web
    /// Services
    /// account used by the application that creates the stream. It is also scoped
    /// by Amazon Web Services Region. That is, two streams in two different Amazon
    /// Web Services accounts
    /// can have the same name. Two streams in the same Amazon Web Services account
    /// but in two
    /// different Regions can also have the same name.
    stream_name: []const u8,

    /// A set of up to 50 key-value pairs to use to create the tags. A tag consists
    /// of a required key and an optional value.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The target warm throughput in MB/s that the stream should be scaled to
    /// handle. This represents the throughput capacity that will be immediately
    /// available for write operations.
    warm_throughput_mi_bps: ?i32 = null,

    pub const json_field_names = .{
        .max_record_size_in_ki_b = "MaxRecordSizeInKiB",
        .shard_count = "ShardCount",
        .stream_mode_details = "StreamModeDetails",
        .stream_name = "StreamName",
        .tags = "Tags",
        .warm_throughput_mi_bps = "WarmThroughputMiBps",
    };
};

pub const CreateStreamOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateStreamInput, options: CallOptions) !CreateStreamOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateStreamInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Kinesis_20131202.CreateStream");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateStreamOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
