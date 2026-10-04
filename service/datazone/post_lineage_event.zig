const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PostLineageEventInput = struct {
    /// A unique, case-sensitive identifier that is provided to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The ID of the domain where you want to post a data lineage event.
    domain_identifier: []const u8,

    /// The data lineage event that you want to post. Only open-lineage run event
    /// are supported as events.
    event: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .domain_identifier = "domainIdentifier",
        .event = "event",
    };
};

pub const PostLineageEventOutput = struct {
    /// The ID of the domain.
    domain_id: ?[]const u8 = null,

    /// The ID of the lineage event.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .domain_id = "domainId",
        .id = "id",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PostLineageEventInput, options: CallOptions) !PostLineageEventOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datazone", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PostLineageEventInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/lineage/events");
    const path = try path_buf.toOwnedSlice(allocator);

    const body = input.event;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.client_token) |v| {
        try request.headers.put(allocator, "Client-Token", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PostLineageEventOutput {
    var result: PostLineageEventOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PostLineageEventOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
