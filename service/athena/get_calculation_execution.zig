const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CalculationResult = @import("calculation_result.zig").CalculationResult;
const CalculationStatistics = @import("calculation_statistics.zig").CalculationStatistics;
const CalculationStatus = @import("calculation_status.zig").CalculationStatus;

pub const GetCalculationExecutionInput = struct {
    /// The calculation execution UUID.
    calculation_execution_id: []const u8,

    pub const json_field_names = .{
        .calculation_execution_id = "CalculationExecutionId",
    };
};

pub const GetCalculationExecutionOutput = struct {
    /// The calculation execution UUID.
    calculation_execution_id: ?[]const u8 = null,

    /// The description of the calculation execution.
    description: ?[]const u8 = null,

    /// Contains result information. This field is populated only if the calculation
    /// is
    /// completed.
    result: ?CalculationResult = null,

    /// The session ID that the calculation ran in.
    session_id: ?[]const u8 = null,

    /// Contains information about the data processing unit (DPU) execution time and
    /// progress.
    /// This field is populated only when statistics are available.
    statistics: ?CalculationStatistics = null,

    /// Contains information about the status of the calculation.
    status: ?CalculationStatus = null,

    /// The Amazon S3 location in which calculation results are stored.
    working_directory: ?[]const u8 = null,

    pub const json_field_names = .{
        .calculation_execution_id = "CalculationExecutionId",
        .description = "Description",
        .result = "Result",
        .session_id = "SessionId",
        .statistics = "Statistics",
        .status = "Status",
        .working_directory = "WorkingDirectory",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCalculationExecutionInput, options: CallOptions) !GetCalculationExecutionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "athena", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCalculationExecutionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("athena", "Athena", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonAthena.GetCalculationExecution");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCalculationExecutionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetCalculationExecutionOutput, body, allocator);
}
