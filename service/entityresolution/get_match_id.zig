const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetMatchIdInput = struct {
    /// Normalizes the attributes defined in the schema in the input data. For
    /// example, if an attribute has an `AttributeType` of `PHONE_NUMBER`, and the
    /// data in the input table is in a format of 1234567890, Entity Resolution will
    /// normalize this field in the output to (123)-456-7890.
    apply_normalization: ?bool = null,

    /// The record to fetch the Match ID for.
    record: []const aws.map.StringMapEntry,

    /// The name of the workflow.
    workflow_name: []const u8,

    pub const json_field_names = .{
        .apply_normalization = "applyNormalization",
        .record = "record",
        .workflow_name = "workflowName",
    };
};

pub const GetMatchIdOutput = struct {
    /// The unique identifiers for this group of match records.
    match_id: ?[]const u8 = null,

    /// The rule the record matched on.
    match_rule: ?[]const u8 = null,

    pub const json_field_names = .{
        .match_id = "matchId",
        .match_rule = "matchRule",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMatchIdInput, options: CallOptions) !GetMatchIdOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "entityresolution", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMatchIdInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("entityresolution", "EntityResolution", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/matchingworkflows/");
    try path_buf.appendSlice(allocator, input.workflow_name);
    try path_buf.appendSlice(allocator, "/matches");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.apply_normalization) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"applyNormalization\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"record\":");
    try aws.json.writeValue(@TypeOf(input.record), input.record, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMatchIdOutput {
    const result: GetMatchIdOutput = try aws.json.parseJsonObject(
        GetMatchIdOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
