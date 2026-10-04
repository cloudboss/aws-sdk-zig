const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ExportStreamSessionFilesInput = struct {
    /// An [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// or ID that uniquely identifies the stream group resource. Example ARN:
    /// `arn:aws:gameliftstreams:us-west-2:111122223333:streamgroup/sg-1AB2C3De4`.
    /// Example ID: `sg-1AB2C3De4`.
    identifier: []const u8,

    /// The S3 bucket URI where Amazon GameLift Streams uploads the set of
    /// compressed exported files for this stream session. Amazon GameLift Streams
    /// generates a ZIP file name based on the stream session metadata.
    /// Alternatively, you can provide a custom file name with a `.zip` file
    /// extension.
    ///
    /// Example 1: If you provide an S3 URI called
    /// `s3://amzn-s3-demo-destination-bucket/MyGame_Session1.zip`, then Amazon
    /// GameLift Streams will save the files at that location.
    ///
    /// Example 2: If you provide an S3 URI called
    /// `s3://amzn-s3-demo-destination-bucket/MyGameSessions_ExportedFiles/`, then
    /// Amazon GameLift Streams will save the files at
    /// `s3://amzn-s3-demo-destination-bucket/MyGameSessions_ExportedFiles/YYYYMMDD-HHMMSS-appId-sg-Id-sessionId.zip` or another similar name.
    output_uri: []const u8,

    /// An [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// or ID that uniquely identifies the stream session resource. Example ARN:
    /// `arn:aws:gameliftstreams:us-west-2:111122223333:streamsession/sg-1AB2C3De4/ABC123def4567`. Example ID: `ABC123def4567`.
    stream_session_identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "Identifier",
        .output_uri = "OutputUri",
        .stream_session_identifier = "StreamSessionIdentifier",
    };
};

pub const ExportStreamSessionFilesOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ExportStreamSessionFilesInput, options: CallOptions) !ExportStreamSessionFilesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "gameliftstreams", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ExportStreamSessionFilesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("gameliftstreams", "GameLiftStreams", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/streamgroups/");
    try path_buf.appendSlice(allocator, input.identifier);
    try path_buf.appendSlice(allocator, "/streamsessions/");
    try path_buf.appendSlice(allocator, input.stream_session_identifier);
    try path_buf.appendSlice(allocator, "/exportfiles");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"OutputUri\":");
    try aws.json.writeValue(@TypeOf(input.output_uri), input.output_uri, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ExportStreamSessionFilesOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: ExportStreamSessionFilesOutput = .{};

    return result;
}
