const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ScalableDimension = @import("scalable_dimension.zig").ScalableDimension;
const ServiceNamespace = @import("service_namespace.zig").ServiceNamespace;
const CapacityForecast = @import("capacity_forecast.zig").CapacityForecast;
const LoadForecast = @import("load_forecast.zig").LoadForecast;

pub const GetPredictiveScalingForecastInput = struct {
    /// The exclusive end time of the time range for the forecast data to get. The
    /// maximum
    /// time duration between the start and end time is 30 days.
    end_time: i64,

    /// The name of the policy.
    policy_name: []const u8,

    /// The identifier of the resource.
    resource_id: []const u8,

    /// The scalable dimension.
    scalable_dimension: ScalableDimension,

    /// The namespace of the Amazon Web Services service that provides the resource.
    /// For a resource provided
    /// by your own application or service, use `custom-resource` instead.
    service_namespace: ServiceNamespace,

    /// The inclusive start time of the time range for the forecast data to get. At
    /// most, the
    /// date and time can be one year before the current date and time
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .policy_name = "PolicyName",
        .resource_id = "ResourceId",
        .scalable_dimension = "ScalableDimension",
        .service_namespace = "ServiceNamespace",
        .start_time = "StartTime",
    };
};

pub const GetPredictiveScalingForecastOutput = struct {
    /// The capacity forecast.
    capacity_forecast: ?CapacityForecast = null,

    /// The load forecast.
    load_forecast: ?[]const LoadForecast = null,

    /// The time the forecast was made.
    update_time: ?i64 = null,

    pub const json_field_names = .{
        .capacity_forecast = "CapacityForecast",
        .load_forecast = "LoadForecast",
        .update_time = "UpdateTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPredictiveScalingForecastInput, options: CallOptions) !GetPredictiveScalingForecastOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "application-autoscaling", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPredictiveScalingForecastInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("application-autoscaling", "Application Auto Scaling", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AnyScaleFrontendService.GetPredictiveScalingForecast");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPredictiveScalingForecastOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetPredictiveScalingForecastOutput, body, allocator);
}
