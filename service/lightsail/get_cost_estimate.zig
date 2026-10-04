const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceBudgetEstimate = @import("resource_budget_estimate.zig").ResourceBudgetEstimate;

pub const GetCostEstimateInput = struct {
    /// The cost estimate end time.
    ///
    /// Constraints:
    ///
    /// * Specified in Coordinated Universal Time (UTC).
    ///
    /// * Specified in the Unix time format.
    ///
    /// For example, if you want to use an end time of October 1, 2018, at 9 PM UTC,
    /// specify
    /// `1538427600` as the end time.
    ///
    /// You can convert a human-friendly time to Unix time format using a converter
    /// like [Epoch converter](https://www.epochconverter.com/).
    end_time: i64,

    /// The resource name.
    resource_name: []const u8,

    /// The cost estimate start time.
    ///
    /// Constraints:
    ///
    /// * Specified in Coordinated Universal Time (UTC).
    ///
    /// * Specified in the Unix time format.
    ///
    /// For example, if you want to use a start time of October 1, 2018, at 8 PM
    /// UTC, specify
    /// `1538424000` as the start time.
    ///
    /// You can convert a human-friendly time to Unix time format using a converter
    /// like [Epoch converter](https://www.epochconverter.com/).
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "endTime",
        .resource_name = "resourceName",
        .start_time = "startTime",
    };
};

pub const GetCostEstimateOutput = struct {
    /// Returns the estimate's forecasted cost or usage.
    resources_budget_estimate: ?[]const ResourceBudgetEstimate = null,

    pub const json_field_names = .{
        .resources_budget_estimate = "resourcesBudgetEstimate",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCostEstimateInput, options: CallOptions) !GetCostEstimateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lightsail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCostEstimateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lightsail", "Lightsail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Lightsail_20161128.GetCostEstimate");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCostEstimateOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetCostEstimateOutput, body, allocator);
}
