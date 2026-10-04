const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MaintenanceWindowExecutionStatus = @import("maintenance_window_execution_status.zig").MaintenanceWindowExecutionStatus;

pub const GetMaintenanceWindowExecutionInput = struct {
    /// The ID of the maintenance window execution that includes the task.
    window_execution_id: []const u8,

    pub const json_field_names = .{
        .window_execution_id = "WindowExecutionId",
    };
};

pub const GetMaintenanceWindowExecutionOutput = struct {
    /// The time the maintenance window finished running.
    end_time: ?i64 = null,

    /// The time the maintenance window started running.
    start_time: ?i64 = null,

    /// The status of the maintenance window execution.
    status: ?MaintenanceWindowExecutionStatus = null,

    /// The details explaining the status. Not available for all status values.
    status_details: ?[]const u8 = null,

    /// The ID of the task executions from the maintenance window execution.
    task_ids: ?[]const []const u8 = null,

    /// The ID of the maintenance window execution.
    window_execution_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .start_time = "StartTime",
        .status = "Status",
        .status_details = "StatusDetails",
        .task_ids = "TaskIds",
        .window_execution_id = "WindowExecutionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMaintenanceWindowExecutionInput, options: CallOptions) !GetMaintenanceWindowExecutionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMaintenanceWindowExecutionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.GetMaintenanceWindowExecution");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMaintenanceWindowExecutionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetMaintenanceWindowExecutionOutput, body, allocator);
}
