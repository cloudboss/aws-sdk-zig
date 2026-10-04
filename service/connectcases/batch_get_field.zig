const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FieldIdentifier = @import("field_identifier.zig").FieldIdentifier;
const FieldError = @import("field_error.zig").FieldError;
const GetFieldResponse = @import("get_field_response.zig").GetFieldResponse;

pub const BatchGetFieldInput = struct {
    /// The unique identifier of the Cases domain.
    domain_id: []const u8,

    /// A list of unique field identifiers.
    fields: []const FieldIdentifier,

    pub const json_field_names = .{
        .domain_id = "domainId",
        .fields = "fields",
    };
};

pub const BatchGetFieldOutput = struct {
    /// A list of field errors.
    errors: ?[]const FieldError = null,

    /// A list of detailed field information.
    fields: ?[]const GetFieldResponse = null,

    pub const json_field_names = .{
        .errors = "errors",
        .fields = "fields",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetFieldInput, options: CallOptions) !BatchGetFieldOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cases", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetFieldInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cases", "ConnectCases", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_id);
    try path_buf.appendSlice(allocator, "/fields-batch");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"fields\":");
    try aws.json.writeValue(@TypeOf(input.fields), input.fields, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetFieldOutput {
    const result: BatchGetFieldOutput = try aws.json.parseJsonObject(
        BatchGetFieldOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
