const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GrantEntitlementRequest = @import("grant_entitlement_request.zig").GrantEntitlementRequest;
const Entitlement = @import("entitlement.zig").Entitlement;

pub const GrantFlowEntitlementsInput = struct {
    /// The list of entitlements that you want to grant.
    entitlements: []const GrantEntitlementRequest,

    /// The Amazon Resource Name (ARN) of the flow that you want to grant
    /// entitlements on.
    flow_arn: []const u8,

    pub const json_field_names = .{
        .entitlements = "Entitlements",
        .flow_arn = "FlowArn",
    };
};

pub const GrantFlowEntitlementsOutput = struct {
    /// The entitlements that were just granted.
    entitlements: ?[]const Entitlement = null,

    /// The ARN of the flow that these entitlements were granted to.
    flow_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .entitlements = "Entitlements",
        .flow_arn = "FlowArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GrantFlowEntitlementsInput, options: CallOptions) !GrantFlowEntitlementsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mediaconnect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GrantFlowEntitlementsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediaconnect", "MediaConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/flows/");
    try path_buf.appendSlice(allocator, input.flow_arn);
    try path_buf.appendSlice(allocator, "/entitlements");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Entitlements\":");
    try aws.json.writeValue(@TypeOf(input.entitlements), input.entitlements, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GrantFlowEntitlementsOutput {
    const result: GrantFlowEntitlementsOutput = try aws.json.parseJsonObject(
        GrantFlowEntitlementsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
