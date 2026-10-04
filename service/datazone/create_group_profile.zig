const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GroupProfileStatus = @import("group_profile_status.zig").GroupProfileStatus;

pub const CreateGroupProfileInput = struct {
    /// A unique, case-sensitive identifier that is provided to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The identifier of the Amazon DataZone domain in which the group profile is
    /// created.
    domain_identifier: []const u8,

    /// The identifier of the group for which the group profile is created.
    group_identifier: ?[]const u8 = null,

    /// The ARN of the IAM role that will be associated with the group profile. This
    /// role defines the permissions that group members will assume when accessing
    /// Amazon DataZone resources.
    role_principal_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .domain_identifier = "domainIdentifier",
        .group_identifier = "groupIdentifier",
        .role_principal_arn = "rolePrincipalArn",
    };
};

pub const CreateGroupProfileOutput = struct {
    /// The identifier of the Amazon DataZone domain in which the group profile is
    /// created.
    domain_id: ?[]const u8 = null,

    /// The name of the group for which group profile is created.
    group_name: ?[]const u8 = null,

    /// The identifier of the group profile.
    id: ?[]const u8 = null,

    /// The ARN of the IAM role principal. This role is associated with the group
    /// profile.
    role_principal_arn: ?[]const u8 = null,

    /// The unique identifier of the IAM role principal. This principal is
    /// associated with the group profile.
    role_principal_id: ?[]const u8 = null,

    /// The status of the group profile.
    status: ?GroupProfileStatus = null,

    pub const json_field_names = .{
        .domain_id = "domainId",
        .group_name = "groupName",
        .id = "id",
        .role_principal_arn = "rolePrincipalArn",
        .role_principal_id = "rolePrincipalId",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateGroupProfileInput, options: CallOptions) !CreateGroupProfileOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateGroupProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/group-profiles");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.group_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"groupIdentifier\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.role_principal_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"rolePrincipalArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateGroupProfileOutput {
    const result: CreateGroupProfileOutput = try aws.json.parseJsonObject(
        CreateGroupProfileOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
