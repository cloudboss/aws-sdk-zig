const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CapacityUnitsConfiguration = @import("capacity_units_configuration.zig").CapacityUnitsConfiguration;

pub const UpdateRescoreExecutionPlanInput = struct {
    /// You can set additional capacity units to meet the needs
    /// of your rescore execution plan. You are given a single capacity
    /// unit by default. If you want to use the default capacity, you
    /// don't set additional capacity units. For more information on the
    /// default capacity and additional capacity units, see
    /// [Adjusting
    /// capacity](https://docs.aws.amazon.com/kendra/latest/dg/adjusting-capacity.html).
    capacity_units: ?CapacityUnitsConfiguration = null,

    /// A new description for the rescore execution plan.
    description: ?[]const u8 = null,

    /// The identifier of the rescore execution plan that you want
    /// to update.
    id: []const u8,

    /// A new name for the rescore execution plan.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .capacity_units = "CapacityUnits",
        .description = "Description",
        .id = "Id",
        .name = "Name",
    };
};

pub const UpdateRescoreExecutionPlanOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateRescoreExecutionPlanInput, options: CallOptions) !UpdateRescoreExecutionPlanOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateRescoreExecutionPlanInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraRerankingFrontendService.UpdateRescoreExecutionPlan");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateRescoreExecutionPlanOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
