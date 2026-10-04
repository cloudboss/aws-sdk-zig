const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SecurityGroupSettings = @import("security_group_settings.zig").SecurityGroupSettings;
const SecurityGroup = @import("security_group.zig").SecurityGroup;

pub const UpdateSecurityGroupInput = struct {
    /// The unique identifier of the security group to update.
    group_id: []const u8,

    /// The new name for the security group.
    name: ?[]const u8 = null,

    /// The ID of the Wickr network containing the security group to update.
    network_id: []const u8,

    /// The updated configuration settings for the security group.
    ///
    /// Federation mode - 0 (Local federation), 1 (Restricted federation), 2 (Global
    /// federation)
    security_group_settings: ?SecurityGroupSettings = null,

    pub const json_field_names = .{
        .group_id = "groupId",
        .name = "name",
        .network_id = "networkId",
        .security_group_settings = "securityGroupSettings",
    };
};

pub const UpdateSecurityGroupOutput = struct {
    /// The updated security group details, including the new settings.
    security_group: ?SecurityGroup = null,

    pub const json_field_names = .{
        .security_group = "securityGroup",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSecurityGroupInput, options: CallOptions) !UpdateSecurityGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wickr", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSecurityGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("admin.wickr", "Wickr", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/networks/");
    try path_buf.appendSlice(allocator, input.network_id);
    try path_buf.appendSlice(allocator, "/security-groups/");
    try path_buf.appendSlice(allocator, input.group_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.security_group_settings) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"securityGroupSettings\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSecurityGroupOutput {
    const result: UpdateSecurityGroupOutput = try aws.json.parseJsonObject(
        UpdateSecurityGroupOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
