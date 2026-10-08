const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetActionInput = struct {
    /// The name of the support action to retrieve.
    action: []const u8,

    pub const json_field_names = .{
        .action = "action",
    };
};

pub const GetActionOutput = struct {
    /// The name of the support action.
    action: []const u8,

    /// A description of what the support action does.
    description: []const u8,

    /// The AWS service associated with the support action.
    service: []const u8,

    pub const json_field_names = .{
        .action = "action",
        .description = "description",
        .service = "service",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetActionInput, options: CallOptions) !GetActionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "supportauthz", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetActionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("supportauthz", "SupportAuthZ", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/actions/");
    try path_buf.appendSlice(allocator, input.action);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetActionOutput {
    const result: GetActionOutput = try aws.json.parseJsonObject(
        GetActionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
