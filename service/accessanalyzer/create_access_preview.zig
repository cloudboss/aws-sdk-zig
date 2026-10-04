const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Configuration = @import("configuration.zig").Configuration;

pub const CreateAccessPreviewInput = struct {
    /// The [ARN of the account
    /// analyzer](https://docs.aws.amazon.com/IAM/latest/UserGuide/access-analyzer-getting-started.html#permission-resources) used to generate the access preview. You can only create an access preview for analyzers with an `Account` type and `Active` status.
    analyzer_arn: []const u8,

    /// A client token.
    client_token: ?[]const u8 = null,

    /// Access control configuration for your resource that is used to generate the
    /// access preview. The access preview includes findings for external access
    /// allowed to the resource with the proposed access control configuration. The
    /// configuration must contain exactly one element.
    configurations: []const aws.map.MapEntry(Configuration),

    pub const json_field_names = .{
        .analyzer_arn = "analyzerArn",
        .client_token = "clientToken",
        .configurations = "configurations",
    };
};

pub const CreateAccessPreviewOutput = struct {
    /// The unique ID for the access preview.
    id: []const u8,

    pub const json_field_names = .{
        .id = "id",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAccessPreviewInput, options: CallOptions) !CreateAccessPreviewOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "access-analyzer", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAccessPreviewInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("access-analyzer", "AccessAnalyzer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/access-preview";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"analyzerArn\":");
    try aws.json.writeValue(@TypeOf(input.analyzer_arn), input.analyzer_arn, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"configurations\":");
    try aws.json.writeValue(@TypeOf(input.configurations), input.configurations, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAccessPreviewOutput {
    const result: CreateAccessPreviewOutput = try aws.json.parseJsonObject(
        CreateAccessPreviewOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
