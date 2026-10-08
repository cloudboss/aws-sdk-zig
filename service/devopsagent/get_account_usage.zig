const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UsageMetric = @import("usage_metric.zig").UsageMetric;

pub const GetAccountUsageInput = struct {};

pub const GetAccountUsageOutput = struct {
    /// Monthly evaluation hours usage and limit for an account
    monthly_account_evaluation_hours: ?UsageMetric = null,

    /// Monthly investigation hours usage and limit for an account
    monthly_account_investigation_hours: ?UsageMetric = null,

    /// Monthly on-demand hours usage and limit for an account
    monthly_account_on_demand_hours: ?UsageMetric = null,

    /// Monthly system learning hours usage and limit for an account
    monthly_account_system_learning_hours: ?UsageMetric = null,

    /// The end time of the usage tracking period
    usage_period_end_time: i64,

    /// The start time of the usage tracking period
    usage_period_start_time: i64,

    pub const json_field_names = .{
        .monthly_account_evaluation_hours = "monthlyAccountEvaluationHours",
        .monthly_account_investigation_hours = "monthlyAccountInvestigationHours",
        .monthly_account_on_demand_hours = "monthlyAccountOnDemandHours",
        .monthly_account_system_learning_hours = "monthlyAccountSystemLearningHours",
        .usage_period_end_time = "usagePeriodEndTime",
        .usage_period_start_time = "usagePeriodStartTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAccountUsageInput, options: CallOptions) !GetAccountUsageOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aidevops", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAccountUsageInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("aidevops", "DevOps Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/usage/account";

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAccountUsageOutput {
    const result: GetAccountUsageOutput = try aws.json.parseJsonObject(
        GetAccountUsageOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
