const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MaintenanceWindowFilter = @import("maintenance_window_filter.zig").MaintenanceWindowFilter;
const MaintenanceWindowExecutionTaskIdentity = @import("maintenance_window_execution_task_identity.zig").MaintenanceWindowExecutionTaskIdentity;

pub const DescribeMaintenanceWindowExecutionTasksInput = struct {
    /// Optional filters used to scope down the returned tasks. The supported filter
    /// key is
    /// `STATUS` with the corresponding values `PENDING`,
    /// `IN_PROGRESS`, `SUCCESS`, `FAILED`, `TIMED_OUT`,
    /// `CANCELLING`, and `CANCELLED`.
    filters: ?[]const MaintenanceWindowFilter = null,

    /// The maximum number of items to return for this call. The call also returns a
    /// token that you
    /// can specify in a subsequent call to get the next set of results.
    max_results: ?i32 = null,

    /// The token for the next set of items to return. (You received this token from
    /// a previous
    /// call.)
    next_token: ?[]const u8 = null,

    /// The ID of the maintenance window execution whose task executions should be
    /// retrieved.
    window_execution_id: []const u8,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .window_execution_id = "WindowExecutionId",
    };
};

pub const DescribeMaintenanceWindowExecutionTasksOutput = struct {
    /// The token to use when requesting the next set of items. If there are no
    /// additional items to
    /// return, the string is empty.
    next_token: ?[]const u8 = null,

    /// Information about the task executions.
    window_execution_task_identities: ?[]const MaintenanceWindowExecutionTaskIdentity = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .window_execution_task_identities = "WindowExecutionTaskIdentities",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeMaintenanceWindowExecutionTasksInput, options: CallOptions) !DescribeMaintenanceWindowExecutionTasksOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeMaintenanceWindowExecutionTasksInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.DescribeMaintenanceWindowExecutionTasks");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeMaintenanceWindowExecutionTasksOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeMaintenanceWindowExecutionTasksOutput, body, allocator);
}
