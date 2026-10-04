const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EntitlementType = @import("entitlement_type.zig").EntitlementType;
const VmEntitlement = @import("vm_entitlement.zig").VmEntitlement;

pub const ListVmEntitlementsInput = struct {
    /// A unique ID for the connector.
    connector_id: []const u8,

    /// The type of entitlement to list.
    entitlement_type: EntitlementType,

    /// A unique ID for the environment.
    environment_id: []const u8,

    /// The maximum number of results to return. If you specify `MaxResults` in the
    /// request, the response includes information up to the limit specified.
    max_results: ?i32 = null,

    /// A unique pagination token for each page. If `nextToken` is returned, there
    /// are more results available. Make the call again using the returned token
    /// with all other arguments unchanged to retrieve the next page. Each
    /// pagination token expires after 24 hours. Using an expired pagination token
    /// will return an *HTTP 400 InvalidToken* error.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .connector_id = "connectorId",
        .entitlement_type = "entitlementType",
        .environment_id = "environmentId",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListVmEntitlementsOutput = struct {
    /// A list of entitlements for virtual machines in the environment.
    entitlements: ?[]const VmEntitlement = null,

    /// A unique pagination token for next page results. Make the call again using
    /// this token to retrieve the next page.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .entitlements = "entitlements",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListVmEntitlementsInput, options: CallOptions) !ListVmEntitlementsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListVmEntitlementsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonElasticVMwareService.ListVmEntitlements");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListVmEntitlementsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListVmEntitlementsOutput, body, allocator);
}
