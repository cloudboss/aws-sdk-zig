const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteUsagePlanKeyInput = struct {
    /// The Id of the UsagePlanKey resource to be deleted.
    key_id: []const u8,

    /// The Id of the UsagePlan resource representing the usage plan containing the
    /// to-be-deleted UsagePlanKey resource representing a plan customer.
    usage_plan_id: []const u8,

    pub const json_field_names = .{
        .key_id = "keyId",
        .usage_plan_id = "usagePlanId",
    };
};

pub const DeleteUsagePlanKeyOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteUsagePlanKeyInput, options: CallOptions) !DeleteUsagePlanKeyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "apigateway", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteUsagePlanKeyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "API Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/usageplans/");
    try path_buf.appendSlice(allocator, input.usage_plan_id);
    try path_buf.appendSlice(allocator, "/keys/");
    try path_buf.appendSlice(allocator, input.key_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteUsagePlanKeyOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DeleteUsagePlanKeyOutput = .{};

    return result;
}
