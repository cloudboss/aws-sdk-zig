const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ListAvailableManagementCidrRangesInput = struct {
    /// The IP address range to search. Specify an IP address range that is
    /// compatible with your
    /// network and in CIDR notation (that is, specify the range as an IPv4 CIDR
    /// block).
    management_cidr_range_constraint: []const u8,

    /// The maximum number of items to return.
    max_results: ?i32 = null,

    /// If you received a `NextToken` from a previous call that was paginated,
    /// provide this token to receive the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .management_cidr_range_constraint = "ManagementCidrRangeConstraint",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListAvailableManagementCidrRangesOutput = struct {
    /// The list of available IP address ranges, specified as IPv4 CIDR blocks.
    management_cidr_ranges: ?[]const []const u8 = null,

    /// The token to use to retrieve the next page of results. This value is null
    /// when there are
    /// no more results to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .management_cidr_ranges = "ManagementCidrRanges",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAvailableManagementCidrRangesInput, options: CallOptions) !ListAvailableManagementCidrRangesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAvailableManagementCidrRangesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "WorkspacesService.ListAvailableManagementCidrRanges");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAvailableManagementCidrRangesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListAvailableManagementCidrRangesOutput, body, allocator);
}
