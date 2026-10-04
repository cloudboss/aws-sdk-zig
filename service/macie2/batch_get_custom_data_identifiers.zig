const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BatchGetCustomDataIdentifierSummary = @import("batch_get_custom_data_identifier_summary.zig").BatchGetCustomDataIdentifierSummary;

pub const BatchGetCustomDataIdentifiersInput = struct {
    /// An array of custom data identifier IDs, one for each custom data identifier
    /// to retrieve information about.
    ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .ids = "ids",
    };
};

pub const BatchGetCustomDataIdentifiersOutput = struct {
    /// An array of objects, one for each custom data identifier that matches the
    /// criteria specified in the request.
    custom_data_identifiers: ?[]const BatchGetCustomDataIdentifierSummary = null,

    /// An array of custom data identifier IDs, one for each custom data identifier
    /// that was specified in the request but doesn't correlate to an existing
    /// custom data identifier.
    not_found_identifier_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .custom_data_identifiers = "customDataIdentifiers",
        .not_found_identifier_ids = "notFoundIdentifierIds",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetCustomDataIdentifiersInput, options: CallOptions) !BatchGetCustomDataIdentifiersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "macie2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetCustomDataIdentifiersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("macie2", "Macie2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/custom-data-identifiers/get";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.ids) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ids\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetCustomDataIdentifiersOutput {
    const result: BatchGetCustomDataIdentifiersOutput = try aws.json.parseJsonObject(
        BatchGetCustomDataIdentifiersOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
