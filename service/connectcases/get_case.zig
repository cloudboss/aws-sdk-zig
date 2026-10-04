const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FieldIdentifier = @import("field_identifier.zig").FieldIdentifier;
const FieldValue = @import("field_value.zig").FieldValue;

pub const GetCaseInput = struct {
    /// A unique identifier of the case.
    case_id: []const u8,

    /// The unique identifier of the Cases domain.
    domain_id: []const u8,

    /// A list of unique field identifiers.
    fields: []const FieldIdentifier,

    /// The token for the next set of results. Use the value returned in the
    /// previous response in the next request to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .case_id = "caseId",
        .domain_id = "domainId",
        .fields = "fields",
        .next_token = "nextToken",
    };
};

pub const GetCaseOutput = struct {
    /// A list of detailed field information.
    fields: ?[]const FieldValue = null,

    /// The token for the next set of results. This is null if there are no more
    /// results to return.
    next_token: ?[]const u8 = null,

    /// A map of of key-value pairs that represent tags on a resource. Tags are used
    /// to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// A unique identifier of a template.
    template_id: []const u8,

    pub const json_field_names = .{
        .fields = "fields",
        .next_token = "nextToken",
        .tags = "tags",
        .template_id = "templateId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCaseInput, options: CallOptions) !GetCaseOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCaseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cases", "ConnectCases", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_id);
    try path_buf.appendSlice(allocator, "/cases/");
    try path_buf.appendSlice(allocator, input.case_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"fields\":");
    try aws.json.writeValue(@TypeOf(input.fields), input.fields, allocator, &body_buf);
    has_prev = true;
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCaseOutput {
    var result: GetCaseOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetCaseOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
