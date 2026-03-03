const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const EndpointType = @import("endpoint_type.zig").EndpointType;
const Platform = @import("platform.zig").Platform;
const PrivateLinkConfig = @import("private_link_config.zig").PrivateLinkConfig;
const AgentStatus = @import("agent_status.zig").AgentStatus;

pub const DescribeAgentInput = struct {
    /// Specifies the Amazon Resource Name (ARN) of the DataSync agent that you want
    /// information about.
    agent_arn: []const u8,

    pub const json_field_names = .{
        .agent_arn = "AgentArn",
    };
};

pub const DescribeAgentOutput = struct {
    /// The ARN of the agent.
    agent_arn: ?[]const u8 = null,

    /// The time that the agent was
    /// [activated](https://docs.aws.amazon.com/datasync/latest/userguide/activate-agent.html).
    creation_time: ?i64 = null,

    /// The type of [service
    /// endpoint](https://docs.aws.amazon.com/datasync/latest/userguide/choose-service-endpoint.html) that your agent is connected to.
    endpoint_type: ?EndpointType = null,

    /// The last time that the agent was communicating with the DataSync
    /// service.
    last_connection_time: ?i64 = null,

    /// The name of the agent.
    name: ?[]const u8 = null,

    /// The platform-related details about the agent, such as the version number.
    platform: ?Platform = null,

    /// The network configuration that the agent uses when connecting to a [VPC
    /// service
    /// endpoint](https://docs.aws.amazon.com/datasync/latest/userguide/choose-service-endpoint.html#choose-service-endpoint-vpc).
    private_link_config: ?PrivateLinkConfig = null,

    /// The status of the agent.
    ///
    /// * If the status is `ONLINE`, the agent is configured properly and ready to
    /// use.
    ///
    /// * If the status is `OFFLINE`, the agent has been out of contact with
    /// DataSync for five minutes or longer. This can happen for a few reasons. For
    /// more information, see [What do I do if my agent is
    /// offline?](https://docs.aws.amazon.com/datasync/latest/userguide/troubleshooting-datasync-agents.html#troubleshoot-agent-offline)
    status: ?AgentStatus = null,

    pub const json_field_names = .{
        .agent_arn = "AgentArn",
        .creation_time = "CreationTime",
        .endpoint_type = "EndpointType",
        .last_connection_time = "LastConnectionTime",
        .name = "Name",
        .platform = "Platform",
        .private_link_config = "PrivateLinkConfig",
        .status = "Status",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAgentInput, options: Options) !DescribeAgentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "datasync");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAgentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datasync", "DataSync", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "FmrsService.DescribeAgent");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAgentOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeAgentOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "InternalException")) {
        return .{ .arena = arena, .kind = .{ .internal_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
