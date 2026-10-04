const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MaintenanceWindowResourceType = @import("maintenance_window_resource_type.zig").MaintenanceWindowResourceType;
const Target = @import("target.zig").Target;
const MaintenanceWindowIdentityForTarget = @import("maintenance_window_identity_for_target.zig").MaintenanceWindowIdentityForTarget;

pub const DescribeMaintenanceWindowsForTargetInput = struct {
    /// The maximum number of items to return for this call. The call also returns a
    /// token that you
    /// can specify in a subsequent call to get the next set of results.
    max_results: ?i32 = null,

    /// The token for the next set of items to return. (You received this token from
    /// a previous
    /// call.)
    next_token: ?[]const u8 = null,

    /// The type of resource you want to retrieve information about. For example,
    /// `INSTANCE`.
    resource_type: MaintenanceWindowResourceType,

    /// The managed node ID or key-value pair to retrieve information about.
    targets: []const Target,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .resource_type = "ResourceType",
        .targets = "Targets",
    };
};

pub const DescribeMaintenanceWindowsForTargetOutput = struct {
    /// The token for the next set of items to return. (You use this token in the
    /// next call.)
    next_token: ?[]const u8 = null,

    /// Information about the maintenance window targets and tasks a managed node is
    /// associated
    /// with.
    window_identities: ?[]const MaintenanceWindowIdentityForTarget = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .window_identities = "WindowIdentities",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeMaintenanceWindowsForTargetInput, options: CallOptions) !DescribeMaintenanceWindowsForTargetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeMaintenanceWindowsForTargetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.DescribeMaintenanceWindowsForTarget");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeMaintenanceWindowsForTargetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeMaintenanceWindowsForTargetOutput, body, allocator);
}
