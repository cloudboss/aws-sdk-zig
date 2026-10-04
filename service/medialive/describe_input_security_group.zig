const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InputSecurityGroupState = @import("input_security_group_state.zig").InputSecurityGroupState;
const InputWhitelistRule = @import("input_whitelist_rule.zig").InputWhitelistRule;

pub const DescribeInputSecurityGroupInput = struct {
    /// The id of the Input Security Group to describe
    input_security_group_id: []const u8,

    pub const json_field_names = .{
        .input_security_group_id = "InputSecurityGroupId",
    };
};

pub const DescribeInputSecurityGroupOutput = struct {
    /// Unique ARN of Input Security Group
    arn: ?[]const u8 = null,

    /// The list of channels currently using this Input Security Group as their
    /// channel security group.
    channels: ?[]const []const u8 = null,

    /// The Id of the Input Security Group
    id: ?[]const u8 = null,

    /// The list of inputs currently using this Input Security Group.
    inputs: ?[]const []const u8 = null,

    /// The current state of the Input Security Group.
    state: ?InputSecurityGroupState = null,

    /// A collection of key-value pairs.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Whitelist rules and their sync status
    whitelist_rules: ?[]const InputWhitelistRule = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .channels = "Channels",
        .id = "Id",
        .inputs = "Inputs",
        .state = "State",
        .tags = "Tags",
        .whitelist_rules = "WhitelistRules",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeInputSecurityGroupInput, options: CallOptions) !DescribeInputSecurityGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "medialive", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeInputSecurityGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medialive", "MediaLive", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/prod/inputSecurityGroups/");
    try path_buf.appendSlice(allocator, input.input_security_group_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeInputSecurityGroupOutput {
    const result: DescribeInputSecurityGroupOutput = try aws.json.parseJsonObject(
        DescribeInputSecurityGroupOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
