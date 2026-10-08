const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AgentConfig = @import("agent_config.zig").AgentConfig;
const SignInConfig = @import("sign_in_config.zig").SignInConfig;
const TelephonyConfig = @import("telephony_config.zig").TelephonyConfig;

pub const UpdateTrafficDistributionInput = struct {
    /// The distribution of agents between the instance and its replica(s).
    agent_config: ?AgentConfig = null,

    /// The identifier of the traffic distribution group.
    /// This can be the ID or the ARN if the API is being called in the Region where
    /// the traffic distribution group was created.
    /// The ARN must be provided if the call is from the replicated Region.
    id: []const u8,

    /// The distribution that determines which Amazon Web Services Regions should be
    /// used to sign in agents in to both
    /// the instance and its replica(s).
    sign_in_config: ?SignInConfig = null,

    /// The distribution of traffic between the instance and its replica(s).
    telephony_config: ?TelephonyConfig = null,

    pub const json_field_names = .{
        .agent_config = "AgentConfig",
        .id = "Id",
        .sign_in_config = "SignInConfig",
        .telephony_config = "TelephonyConfig",
    };
};

pub const UpdateTrafficDistributionOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateTrafficDistributionInput, options: CallOptions) !UpdateTrafficDistributionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateTrafficDistributionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/traffic-distribution/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.agent_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AgentConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sign_in_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SignInConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.telephony_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TelephonyConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateTrafficDistributionOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateTrafficDistributionOutput = .{};

    return result;
}
