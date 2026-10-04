const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FindingStatusUpdate = @import("finding_status_update.zig").FindingStatusUpdate;

pub const UpdateFindingsInput = struct {
    /// The [ARN of the
    /// analyzer](https://docs.aws.amazon.com/IAM/latest/UserGuide/access-analyzer-getting-started.html#permission-resources) that generated the findings to update.
    analyzer_arn: []const u8,

    /// A client token.
    client_token: ?[]const u8 = null,

    /// The IDs of the findings to update.
    ids: ?[]const []const u8 = null,

    /// The ARN of the resource identified in the finding.
    resource_arn: ?[]const u8 = null,

    /// The state represents the action to take to update the finding Status. Use
    /// `ARCHIVE` to change an Active finding to an Archived finding. Use `ACTIVE`
    /// to change an Archived finding to an Active finding.
    status: FindingStatusUpdate,

    pub const json_field_names = .{
        .analyzer_arn = "analyzerArn",
        .client_token = "clientToken",
        .ids = "ids",
        .resource_arn = "resourceArn",
        .status = "status",
    };
};

pub const UpdateFindingsOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateFindingsInput, options: CallOptions) !UpdateFindingsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateFindingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("access-analyzer", "AccessAnalyzer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/finding";

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
    if (input.ids) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ids\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.resource_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"resourceArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"status\":");
    try aws.json.writeValue(@TypeOf(input.status), input.status, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateFindingsOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateFindingsOutput = .{};

    return result;
}
