const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccountEnrollmentStatus = @import("account_enrollment_status.zig").AccountEnrollmentStatus;

pub const ListEnrollmentStatusesInput = struct {
    /// The account ID of a member account in the organization.
    account_id: ?[]const u8 = null,

    /// Indicates whether to return the enrollment status for the organization.
    include_organization_info: ?bool = null,

    /// The maximum number of objects that are returned for the request.
    max_results: ?i32 = null,

    /// The token to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "accountId",
        .include_organization_info = "includeOrganizationInfo",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListEnrollmentStatusesOutput = struct {
    /// The enrollment status of all member accounts in the organization if the
    /// account is the management account or delegated administrator.
    include_member_accounts: ?bool = null,

    /// The enrollment status of a specific account ID, including creation and last
    /// updated timestamps.
    items: ?[]const AccountEnrollmentStatus = null,

    /// The token to retrieve the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .include_member_accounts = "includeMemberAccounts",
        .items = "items",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEnrollmentStatusesInput, options: CallOptions) !ListEnrollmentStatusesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "costoptimizationhubservice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListEnrollmentStatusesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cost-optimization-hub", "Cost Optimization Hub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "CostOptimizationHubService.ListEnrollmentStatuses");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListEnrollmentStatusesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListEnrollmentStatusesOutput, body, allocator);
}
