const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DedicatedTenancyAccountType = @import("dedicated_tenancy_account_type.zig").DedicatedTenancyAccountType;
const DedicatedTenancySupportResultEnum = @import("dedicated_tenancy_support_result_enum.zig").DedicatedTenancySupportResultEnum;

pub const DescribeAccountInput = struct {
};

pub const DescribeAccountOutput = struct {
    /// The type of linked account.
    dedicated_tenancy_account_type: ?DedicatedTenancyAccountType = null,

    /// The IP address range, specified as an IPv4 CIDR block, used for the
    /// management network
    /// interface.
    ///
    /// The management network interface is connected to a secure Amazon WorkSpaces
    /// management
    /// network. It is used for interactive streaming of the WorkSpace desktop to
    /// Amazon WorkSpaces
    /// clients, and to allow Amazon WorkSpaces to manage the WorkSpace.
    dedicated_tenancy_management_cidr_range: ?[]const u8 = null,

    /// The status of BYOL (whether BYOL is enabled or disabled).
    dedicated_tenancy_support: ?DedicatedTenancySupportResultEnum = null,

    /// The text message to describe the status of BYOL.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .dedicated_tenancy_account_type = "DedicatedTenancyAccountType",
        .dedicated_tenancy_management_cidr_range = "DedicatedTenancyManagementCidrRange",
        .dedicated_tenancy_support = "DedicatedTenancySupport",
        .message = "Message",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAccountInput, options: CallOptions) !DescribeAccountOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAccountInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("workspaces", "WorkSpaces", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = "{}";

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "WorkspacesService.DescribeAccount");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAccountOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeAccountOutput, body, allocator);
}
