const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DedicatedTenancySupportEnum = @import("dedicated_tenancy_support_enum.zig").DedicatedTenancySupportEnum;

pub const ModifyAccountInput = struct {
    /// The IP address range, specified as an IPv4 CIDR block, for the management
    /// network
    /// interface. Specify an IP address range that is compatible with your network
    /// and in CIDR
    /// notation (that is, specify the range as an IPv4 CIDR block). The CIDR block
    /// size must be
    /// /16 (for example, 203.0.113.25/16). It must also be specified as available
    /// by the
    /// `ListAvailableManagementCidrRanges` operation.
    dedicated_tenancy_management_cidr_range: ?[]const u8 = null,

    /// The status of BYOL.
    dedicated_tenancy_support: ?DedicatedTenancySupportEnum = null,

    pub const json_field_names = .{
        .dedicated_tenancy_management_cidr_range = "DedicatedTenancyManagementCidrRange",
        .dedicated_tenancy_support = "DedicatedTenancySupport",
    };
};

pub const ModifyAccountOutput = struct {
    /// The text message to describe the status of BYOL modification.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyAccountInput, options: CallOptions) !ModifyAccountOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workspaces", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyAccountInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workspaces", "WorkSpaces", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "WorkspacesService.ModifyAccount");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyAccountOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ModifyAccountOutput, body, allocator);
}
