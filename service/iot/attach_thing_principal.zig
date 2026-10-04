const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ThingPrincipalType = @import("thing_principal_type.zig").ThingPrincipalType;

pub const AttachThingPrincipalInput = struct {
    /// The principal, which can be a certificate ARN (as returned from the
    /// CreateCertificate operation) or an Amazon Cognito ID.
    principal: []const u8,

    /// The name of the thing.
    thing_name: []const u8,

    /// The type of the relation you want to specify when you attach a principal to
    /// a thing.
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
        .principal = "principal",
        .thing_name = "thingName",
        .thing_principal_type = "thingPrincipalType",
    };
};

pub const AttachThingPrincipalOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AttachThingPrincipalInput, options: CallOptions) !AttachThingPrincipalOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: AttachThingPrincipalInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/things/");
    try path_buf.appendSlice(allocator, input.thing_name);
    try path_buf.appendSlice(allocator, "/principals");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.thing_principal_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "thingPrincipalType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");
    try request.headers.put(allocator, "x-amzn-principal", input.principal);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AttachThingPrincipalOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: AttachThingPrincipalOutput = .{};

    return result;
}
