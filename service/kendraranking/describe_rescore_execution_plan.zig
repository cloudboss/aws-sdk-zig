const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CapacityUnitsConfiguration = @import("capacity_units_configuration.zig").CapacityUnitsConfiguration;
const RescoreExecutionPlanStatus = @import("rescore_execution_plan_status.zig").RescoreExecutionPlanStatus;

pub const DescribeRescoreExecutionPlanInput = struct {
    /// The identifier of the rescore execution plan that you want
    /// to get information on.
    id: []const u8,

    pub const json_field_names = .{
        .id = "Id",
    };
};

pub const DescribeRescoreExecutionPlanOutput = struct {
    /// The Amazon Resource Name (ARN) of the rescore execution
    /// plan.
    arn: ?[]const u8 = null,

    /// The capacity units set for the rescore execution plan.
    /// A capacity of zero indicates that the rescore execution
    /// plan is using the default capacity. For more information on the
    /// default capacity and additional capacity units, see [Adjusting
    /// capacity](https://docs.aws.amazon.com/kendra/latest/dg/adjusting-capacity.html).
    capacity_units: ?CapacityUnitsConfiguration = null,

    /// The Unix timestamp of when the rescore execution plan was
    /// created.
    created_at: ?i64 = null,

    /// The description for the rescore execution plan.
    description: ?[]const u8 = null,

    /// When the `Status` field value is
    /// `FAILED`, the `ErrorMessage` field
    /// contains a message that explains why.
    error_message: ?[]const u8 = null,

    /// The identifier of the rescore execution plan.
    id: ?[]const u8 = null,

    /// The name for the rescore execution plan.
    name: ?[]const u8 = null,

    /// The current status of the rescore execution plan. When the
    /// value is `ACTIVE`, the rescore execution plan is
    /// ready for use. If the `Status` field value is
    /// `FAILED`, the `ErrorMessage` field
    /// contains a message that explains why.
    status: ?RescoreExecutionPlanStatus = null,

    /// The Unix timestamp of when the rescore execution plan was
    /// last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .capacity_units = "CapacityUnits",
        .created_at = "CreatedAt",
        .description = "Description",
        .error_message = "ErrorMessage",
        .id = "Id",
        .name = "Name",
        .status = "Status",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeRescoreExecutionPlanInput, options: CallOptions) !DescribeRescoreExecutionPlanOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kendra-ranking", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeRescoreExecutionPlanInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kendra-ranking", "Kendra Ranking", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraRerankingFrontendService.DescribeRescoreExecutionPlan");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeRescoreExecutionPlanOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeRescoreExecutionPlanOutput, body, allocator);
}
