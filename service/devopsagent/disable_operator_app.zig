const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthFlow = @import("auth_flow.zig").AuthFlow;

pub const DisableOperatorAppInput = struct {
    /// The unique identifier of the AgentSpace
    agent_space_id: []const u8,

    /// The authentication flow configured for the operator App. e.g. idc
    auth_flow: ?AuthFlow = null,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .auth_flow = "authFlow",
    };
};

pub const DisableOperatorAppOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DisableOperatorAppInput, options: CallOptions) !DisableOperatorAppOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aidevops", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DisableOperatorAppInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aidevops", "DevOps Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/agentspaces/");
    try path_buf.appendSlice(allocator, input.agent_space_id);
    try path_buf.appendSlice(allocator, "/operator");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.auth_flow) |v| {
        try request.headers.put(allocator, "x-amzn-app-auth-flow", v.wireName());
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DisableOperatorAppOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DisableOperatorAppOutput = .{};

    return result;
}
