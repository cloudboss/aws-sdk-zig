const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Entitlement = @import("entitlement.zig").Entitlement;

pub const CreateEntitlementInput = struct {
    /// Specifies the ARN of the application to create the entitlement for.
    application_arn: []const u8,

    /// Specifies the entitlement configuration, including the principal and the IAM
    /// role to grant access to.
    entitlement: Entitlement,

    pub const json_field_names = .{
        .application_arn = "applicationArn",
        .entitlement = "entitlement",
    };
};

pub const CreateEntitlementOutput = struct {
    /// The unique identifier of the created entitlement.
    entitlement_id: []const u8,

    pub const json_field_names = .{
        .entitlement_id = "entitlementId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEntitlementInput, options: CallOptions) !CreateEntitlementOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "account-access", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEntitlementInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("account-access", "Account Access", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/entitlements";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"applicationArn\":");
    try aws.json.writeValue(@TypeOf(input.application_arn), input.application_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"entitlement\":");
    try aws.json.writeValue(@TypeOf(input.entitlement), input.entitlement, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEntitlementOutput {
    const result: CreateEntitlementOutput = try aws.json.parseJsonObject(
        CreateEntitlementOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
