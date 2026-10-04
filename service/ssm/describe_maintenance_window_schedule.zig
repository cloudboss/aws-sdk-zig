const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PatchOrchestratorFilter = @import("patch_orchestrator_filter.zig").PatchOrchestratorFilter;
const MaintenanceWindowResourceType = @import("maintenance_window_resource_type.zig").MaintenanceWindowResourceType;
const Target = @import("target.zig").Target;
const ScheduledWindowExecution = @import("scheduled_window_execution.zig").ScheduledWindowExecution;

pub const DescribeMaintenanceWindowScheduleInput = struct {
    /// Filters used to limit the range of results. For example, you can limit
    /// maintenance window
    /// executions to only those scheduled before or after a certain date and time.
    filters: ?[]const PatchOrchestratorFilter = null,

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
    resource_type: ?MaintenanceWindowResourceType = null,

    /// The managed node ID or key-value pair to retrieve information about.
    targets: ?[]const Target = null,

    /// The ID of the maintenance window to retrieve information about.
    window_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .resource_type = "ResourceType",
        .targets = "Targets",
        .window_id = "WindowId",
    };
};

pub const DescribeMaintenanceWindowScheduleOutput = struct {
    /// The token for the next set of items to return. (You use this token in the
    /// next call.)
    next_token: ?[]const u8 = null,

    /// Information about maintenance window executions scheduled for the specified
    /// time
    /// range.
    scheduled_window_executions: ?[]const ScheduledWindowExecution = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .scheduled_window_executions = "ScheduledWindowExecutions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeMaintenanceWindowScheduleInput, options: CallOptions) !DescribeMaintenanceWindowScheduleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeMaintenanceWindowScheduleInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.DescribeMaintenanceWindowSchedule");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeMaintenanceWindowScheduleOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeMaintenanceWindowScheduleOutput, body, allocator);
}
