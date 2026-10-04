const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Identity = @import("identity.zig").Identity;
const Permission = @import("permission.zig").Permission;
const Resource = @import("resource.zig").Resource;

pub const UpdateAccessPolicyInput = struct {
    /// The ID of the access policy.
    access_policy_id: []const u8,

    /// The identity for this access policy. Choose an IAM Identity Center user, an
    /// IAM Identity Center group, or an IAM user.
    access_policy_identity: Identity,

    /// The permission level for this access policy. Note that a project
    /// `ADMINISTRATOR` is also known as a project owner.
    access_policy_permission: Permission,

    /// The IoT SiteWise Monitor resource for this access policy. Choose either a
    /// portal or a project.
    access_policy_resource: Resource,

    /// A unique case-sensitive identifier that you can provide to ensure the
    /// idempotency of the request. Don't reuse this client token if a new
    /// idempotent request is required.
    client_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .access_policy_id = "accessPolicyId",
        .access_policy_identity = "accessPolicyIdentity",
        .access_policy_permission = "accessPolicyPermission",
        .access_policy_resource = "accessPolicyResource",
        .client_token = "clientToken",
    };
};

pub const UpdateAccessPolicyOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAccessPolicyInput, options: CallOptions) !UpdateAccessPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotsitewise", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAccessPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/access-policies/");
    try path_buf.appendSlice(allocator, input.access_policy_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"accessPolicyIdentity\":");
    try aws.json.writeValue(@TypeOf(input.access_policy_identity), input.access_policy_identity, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"accessPolicyPermission\":");
    try aws.json.writeValue(@TypeOf(input.access_policy_permission), input.access_policy_permission, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"accessPolicyResource\":");
    try aws.json.writeValue(@TypeOf(input.access_policy_resource), input.access_policy_resource, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAccessPolicyOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateAccessPolicyOutput = .{};

    return result;
}
