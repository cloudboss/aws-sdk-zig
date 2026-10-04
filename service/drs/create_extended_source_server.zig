const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SourceServer = @import("source_server.zig").SourceServer;

pub const CreateExtendedSourceServerInput = struct {
    /// This defines the ARN of the source server in staging Account based on which
    /// you want to create an extended source server.
    source_server_arn: []const u8,

    /// A list of tags associated with the extended source server.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .source_server_arn = "sourceServerArn",
        .tags = "tags",
    };
};

pub const CreateExtendedSourceServerOutput = struct {
    /// Created extended source server.
    source_server: ?SourceServer = null,

    pub const json_field_names = .{
        .source_server = "sourceServer",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateExtendedSourceServerInput, options: CallOptions) !CreateExtendedSourceServerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "drs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateExtendedSourceServerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("drs", "drs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/CreateExtendedSourceServer";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"sourceServerArn\":");
    try aws.json.writeValue(@TypeOf(input.source_server_arn), input.source_server_arn, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateExtendedSourceServerOutput {
    const result: CreateExtendedSourceServerOutput = try aws.json.parseJsonObject(
        CreateExtendedSourceServerOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
