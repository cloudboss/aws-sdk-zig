const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ThingAttribute = @import("thing_attribute.zig").ThingAttribute;

pub const ListThingsInput = struct {
    /// The attribute name used to search for things.
    attribute_name: ?[]const u8 = null,

    /// The attribute value used to search for things.
    attribute_value: ?[]const u8 = null,

    /// The maximum number of results to return in this operation.
    max_results: ?i32 = null,

    /// To retrieve the next set of results, the `nextToken`
    /// value from a previous response; otherwise **null** to receive
    /// the first set of results.
    next_token: ?[]const u8 = null,

    /// The name of the thing type used to search for things.
    thing_type_name: ?[]const u8 = null,

    /// When `true`, the action returns the thing resources with attribute values
    /// that start with the `attributeValue` provided.
    ///
    /// When `false`, or not present, the action returns only the thing
    /// resources with attribute values that match the entire `attributeValue`
    /// provided.
    use_prefix_attribute_value: ?bool = null,

    pub const json_field_names = .{
        .attribute_name = "attributeName",
        .attribute_value = "attributeValue",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .thing_type_name = "thingTypeName",
        .use_prefix_attribute_value = "usePrefixAttributeValue",
    };
};

pub const ListThingsOutput = struct {
    /// The token to use to get the next set of results. Will not be returned if
    /// operation has returned all results.
    next_token: ?[]const u8 = null,

    /// The things.
    things: ?[]const ThingAttribute = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .things = "things",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListThingsInput, options: CallOptions) !ListThingsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListThingsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/things";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.attribute_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "attributeName=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.attribute_value) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "attributeValue=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
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
    if (input.thing_type_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "thingTypeName=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.use_prefix_attribute_value) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "usePrefixAttributeValue=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListThingsOutput {
    var result: ListThingsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListThingsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
