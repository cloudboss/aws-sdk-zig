const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ThingPrincipalType = @import("thing_principal_type.zig").ThingPrincipalType;
const ThingPrincipalObject = @import("thing_principal_object.zig").ThingPrincipalObject;

pub const ListThingPrincipalsV2Input = struct {
    /// The maximum number of results to return in this operation.
    max_results: ?i32 = null,

    /// To retrieve the next set of results, the `nextToken`
    /// value from a previous response; otherwise **null** to receive
    /// the first set of results.
    next_token: ?[]const u8 = null,

    /// The name of the thing.
    thing_name: []const u8,

    /// The type of the relation you want to filter in the response. If no value is
    /// provided in
    /// this field, the response will list all principals, including both the
    /// `EXCLUSIVE_THING` and `NON_EXCLUSIVE_THING` attachment
    /// types.
    ///
    /// * `EXCLUSIVE_THING` - Attaches the specified principal to the specified
    ///   thing, exclusively.
    /// The thing will be the only thing that’s attached to the principal.
    ///
    /// * `NON_EXCLUSIVE_THING` - Attaches the specified principal to the specified
    ///   thing.
    /// Multiple things can be attached to the principal.
    thing_principal_type: ?ThingPrincipalType = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .thing_name = "thingName",
        .thing_principal_type = "thingPrincipalType",
    };
};

pub const ListThingPrincipalsV2Output = struct {
    /// The token to use to get the next set of results, or **null** if there are no
    /// additional results.
    next_token: ?[]const u8 = null,

    /// A list of `thingPrincipalObject` that represents the principal and the type
    /// of relation it has
    /// with the thing.
    thing_principal_objects: ?[]const ThingPrincipalObject = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .thing_principal_objects = "thingPrincipalObjects",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListThingPrincipalsV2Input, options: CallOptions) !ListThingPrincipalsV2Output {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListThingPrincipalsV2Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/things/");
    try path_buf.appendSlice(allocator, input.thing_name);
    try path_buf.appendSlice(allocator, "/principals-v2");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
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
    if (input.thing_principal_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "thingPrincipalType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListThingPrincipalsV2Output {
    const result: ListThingPrincipalsV2Output = try aws.json.parseJsonObject(
        ListThingPrincipalsV2Output,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
