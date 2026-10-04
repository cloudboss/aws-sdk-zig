const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ApproximationDimension = @import("approximation_dimension.zig").ApproximationDimension;
const Granularity = @import("granularity.zig").Granularity;
const DateInterval = @import("date_interval.zig").DateInterval;

pub const GetApproximateUsageRecordsInput = struct {
    /// The service to evaluate for the usage records. You can choose resource-level
    /// data at daily
    /// granularity, or hourly granularity with or without resource-level data.
    approximation_dimension: ApproximationDimension,

    /// How granular you want the data to be. You can enable data at hourly or daily
    /// granularity.
    granularity: Granularity,

    /// The service metadata for the service or services you want to query. If not
    /// specified, all
    /// elements are returned.
    services: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .approximation_dimension = "ApproximationDimension",
        .granularity = "Granularity",
        .services = "Services",
    };
};

pub const GetApproximateUsageRecordsOutput = struct {
    /// The lookback period that's used for the estimation.
    lookback_period: ?DateInterval = null,

    /// The service metadata for the service or services in the response.
    services: ?[]const aws.map.MapEntry(i64) = null,

    /// The total number of usage records for all services in the services list.
    total_records: ?i64 = null,

    pub const json_field_names = .{
        .lookback_period = "LookbackPeriod",
        .services = "Services",
        .total_records = "TotalRecords",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetApproximateUsageRecordsInput, options: CallOptions) !GetApproximateUsageRecordsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ce", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetApproximateUsageRecordsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ce", "Cost Explorer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSInsightsIndexService.GetApproximateUsageRecords");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetApproximateUsageRecordsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetApproximateUsageRecordsOutput, body, allocator);
}
