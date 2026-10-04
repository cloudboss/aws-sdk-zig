const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MaintenanceWindowFilter = @import("maintenance_window_filter.zig").MaintenanceWindowFilter;
const MaintenanceWindowExecution = @import("maintenance_window_execution.zig").MaintenanceWindowExecution;

pub const DescribeMaintenanceWindowExecutionsInput = struct {
    /// Each entry in the array is a structure containing:
    ///
    /// * Key. A string between 1 and 128 characters. Supported keys include
    /// `ExecutedBefore` and `ExecutedAfter`.
    ///
    /// * Values. An array of strings, each between 1 and 256 characters. Supported
    ///   values are
    /// date/time strings in a valid ISO 8601 date/time format, such as
    /// `2024-11-04T05:00:00Z`.
    filters: ?[]const MaintenanceWindowFilter = null,

    /// The maximum number of items to return for this call. The call also returns a
    /// token that you
    /// can specify in a subsequent call to get the next set of results.
    max_results: ?i32 = null,

    /// The token for the next set of items to return. (You received this token from
    /// a previous
    /// call.)
    next_token: ?[]const u8 = null,

    /// The ID of the maintenance window whose executions should be retrieved.
    window_id: []const u8,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .window_id = "WindowId",
    };
};

pub const DescribeMaintenanceWindowExecutionsOutput = struct {
    /// The token to use when requesting the next set of items. If there are no
    /// additional items to
    /// return, the string is empty.
    next_token: ?[]const u8 = null,

    /// Information about the maintenance window executions.
    window_executions: ?[]const MaintenanceWindowExecution = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .window_executions = "WindowExecutions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeMaintenanceWindowExecutionsInput, options: CallOptions) !DescribeMaintenanceWindowExecutionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeMaintenanceWindowExecutionsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.DescribeMaintenanceWindowExecutions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeMaintenanceWindowExecutionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeMaintenanceWindowExecutionsOutput, body, allocator);
}
