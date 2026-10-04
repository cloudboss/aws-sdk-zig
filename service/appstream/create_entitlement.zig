const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AppVisibility = @import("app_visibility.zig").AppVisibility;
const EntitlementAttribute = @import("entitlement_attribute.zig").EntitlementAttribute;
const Entitlement = @import("entitlement.zig").Entitlement;

pub const CreateEntitlementInput = struct {
    /// Specifies whether all or selected apps are entitled.
    app_visibility: AppVisibility,

    /// The attributes of the entitlement.
    attributes: []const EntitlementAttribute,

    /// The description of the entitlement.
    description: ?[]const u8 = null,

    /// The name of the entitlement.
    name: []const u8,

    /// The name of the stack with which the entitlement is associated.
    stack_name: []const u8,

    pub const json_field_names = .{
        .app_visibility = "AppVisibility",
        .attributes = "Attributes",
        .description = "Description",
        .name = "Name",
        .stack_name = "StackName",
    };
};

pub const CreateEntitlementOutput = struct {
    /// The entitlement.
    entitlement: ?Entitlement = null,

    pub const json_field_names = .{
        .entitlement = "Entitlement",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEntitlementInput, options: CallOptions) !CreateEntitlementOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appstream", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("appstream2", "AppStream", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "PhotonAdminProxyService.CreateEntitlement");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEntitlementOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateEntitlementOutput, body, allocator);
}
