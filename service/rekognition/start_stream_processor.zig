const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StreamProcessingStartSelector = @import("stream_processing_start_selector.zig").StreamProcessingStartSelector;
const StreamProcessingStopSelector = @import("stream_processing_stop_selector.zig").StreamProcessingStopSelector;

pub const StartStreamProcessorInput = struct {
    /// The name of the stream processor to start processing.
    name: []const u8,

    /// Specifies the starting point in the Kinesis stream to start processing.
    /// You can use the producer timestamp or the fragment number. If you use the
    /// producer timestamp, you must put the time in milliseconds.
    /// For more information about fragment numbers, see
    /// [Fragment](https://docs.aws.amazon.com/kinesisvideostreams/latest/dg/API_reader_Fragment.html).
    ///
    /// This is a required parameter for label detection stream processors and
    /// should not be used to start a face search stream processor.
    start_selector: ?StreamProcessingStartSelector = null,

    /// Specifies when to stop processing the stream. You can specify a
    /// maximum amount of time to process the video.
    ///
    /// This is a required parameter for label detection stream processors and
    /// should not be used to start a face search stream processor.
    stop_selector: ?StreamProcessingStopSelector = null,

    pub const json_field_names = .{
        .name = "Name",
        .start_selector = "StartSelector",
        .stop_selector = "StopSelector",
    };
};

pub const StartStreamProcessorOutput = struct {
    /// A unique identifier for the stream processing session.
    session_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .session_id = "SessionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartStreamProcessorInput, options: CallOptions) !StartStreamProcessorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rekognition", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartStreamProcessorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rekognition", "Rekognition", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.StartStreamProcessor");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartStreamProcessorOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartStreamProcessorOutput, body, allocator);
}
