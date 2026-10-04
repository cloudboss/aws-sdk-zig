const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EntitlementType = @import("entitlement_type.zig").EntitlementType;
const VmEntitlement = @import("vm_entitlement.zig").VmEntitlement;

pub const CreateEntitlementInput = struct {
    /// This parameter is not used in Amazon EVS currently. If you supply input for
    /// this parameter, it will have no effect.
    ///
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the entitlement creation request. If you do not specify a
    /// client token, a randomly generated token is used for the request to ensure
    /// idempotency.
    client_token: ?[]const u8 = null,

    /// A unique ID for the connector associated with the entitlement.
    connector_id: []const u8,

    /// The type of entitlement to create.
    entitlement_type: EntitlementType,

    /// A unique ID for the environment to create the entitlement in.
    environment_id: []const u8,

    /// The list of VMware vSphere virtual machine managed object IDs to create
    /// entitlements for.
    vm_ids: []const []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .connector_id = "connectorId",
        .entitlement_type = "entitlementType",
        .environment_id = "environmentId",
        .vm_ids = "vmIds",
    };
};

pub const CreateEntitlementOutput = struct {
    /// A list of the created entitlements.
    entitlements: ?[]const VmEntitlement = null,

    pub const json_field_names = .{
        .entitlements = "entitlements",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEntitlementInput, options: CallOptions) !CreateEntitlementOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "evs", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("evs", "evs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonElasticVMwareService.CreateEntitlement");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEntitlementOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateEntitlementOutput, body, allocator);
}
