const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Locale = @import("locale.zig").Locale;
const BuiltinSlotTypeMetadata = @import("builtin_slot_type_metadata.zig").BuiltinSlotTypeMetadata;

pub const GetBuiltinSlotTypesInput = struct {
    /// A list of locales that the slot type supports.
    locale: ?Locale = null,

    /// The maximum number of slot types to return in the response. The
    /// default is 10.
    max_results: ?i32 = null,

    /// A pagination token that fetches the next page of slot types. If the
    /// response to this API call is truncated, Amazon Lex returns a pagination
    /// token
    /// in the response. To fetch the next page of slot types, specify the
    /// pagination token in the next request.
    next_token: ?[]const u8 = null,

    /// Substring to match in built-in slot type signatures. A slot type
    /// will be returned if any part of its signature matches the substring. For
    /// example, "xyz" matches both "xyzabc" and "abcxyz."
    signature_contains: ?[]const u8 = null,

    pub const json_field_names = .{
        .locale = "locale",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .signature_contains = "signatureContains",
    };
};

pub const GetBuiltinSlotTypesOutput = struct {
    /// If the response is truncated, the response includes a pagination
    /// token that you can use in your next request to fetch the next page of slot
    /// types.
    next_token: ?[]const u8 = null,

    /// An array of `BuiltInSlotTypeMetadata` objects, one entry
    /// for each slot type returned.
    slot_types: ?[]const BuiltinSlotTypeMetadata = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .slot_types = "slotTypes",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBuiltinSlotTypesInput, options: CallOptions) !GetBuiltinSlotTypesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lex", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBuiltinSlotTypesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models.lex", "Lex Model Building Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/builtins/slottypes";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.locale) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "locale=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.signature_contains) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "signatureContains=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBuiltinSlotTypesOutput {
    var result: GetBuiltinSlotTypesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetBuiltinSlotTypesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
