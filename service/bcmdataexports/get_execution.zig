const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;
const Export = @import("export.zig").Export;

pub const GetExecutionInput = struct {
    /// The ID for this specific execution.
    execution_id: []const u8,

    /// The Amazon Resource Name (ARN) of the Export object that generated this
    /// specific execution.
    export_arn: []const u8,

    pub const json_field_names = .{
        .execution_id = "ExecutionId",
        .export_arn = "ExportArn",
    };
};

pub const GetExecutionOutput = struct {
    /// The ID for this specific execution.
    execution_id: ?[]const u8 = null,

    /// The status of this specific execution.
    execution_status: ?ExecutionStatus = null,

    /// The export data for this specific execution. This export data is a snapshot
    /// from when the execution was generated. The data could be different from the
    /// current export data if the export was updated since the execution was
    /// generated.
    @"export": ?Export = null,

    pub const json_field_names = .{
        .execution_id = "ExecutionId",
        .execution_status = "ExecutionStatus",
        .@"export" = "Export",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetExecutionInput, options: CallOptions) !GetExecutionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bcm-data-exports", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bcm-data-exports", "BCM Data Exports", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSBillingAndCostManagementDataExports.GetExecution");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetExecutionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetExecutionOutput, body, allocator);
}
