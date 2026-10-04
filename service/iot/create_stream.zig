const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StreamFile = @import("stream_file.zig").StreamFile;
const Tag = @import("tag.zig").Tag;

pub const CreateStreamInput = struct {
    /// A description of the stream.
    description: ?[]const u8 = null,

    /// The files to stream.
    files: []const StreamFile,

    /// An IAM role that allows the IoT service principal to access your S3 files.
    role_arn: []const u8,

    /// The stream ID.
    stream_id: []const u8,

    /// Metadata which can be used to manage streams.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .description = "description",
        .files = "files",
        .role_arn = "roleArn",
        .stream_id = "streamId",
        .tags = "tags",
    };
};

pub const CreateStreamOutput = struct {
    /// A description of the stream.
    description: ?[]const u8 = null,

    /// The stream ARN.
    stream_arn: ?[]const u8 = null,

    /// The stream ID.
    stream_id: ?[]const u8 = null,

    /// The version of the stream.
    stream_version: ?i32 = null,

    pub const json_field_names = .{
        .description = "description",
        .stream_arn = "streamArn",
        .stream_id = "streamId",
        .stream_version = "streamVersion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateStreamInput, options: CallOptions) !CreateStreamOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/streams/");
    try path_buf.appendSlice(allocator, input.stream_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"files\":");
    try aws.json.writeValue(@TypeOf(input.files), input.files, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"roleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateStreamOutput {
    const result: CreateStreamOutput = try aws.json.parseJsonObject(
        CreateStreamOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
