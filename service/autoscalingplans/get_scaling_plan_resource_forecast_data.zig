const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const ForecastDataType = @import("forecast_data_type.zig").ForecastDataType;
const ScalableDimension = @import("scalable_dimension.zig").ScalableDimension;
const ServiceNamespace = @import("service_namespace.zig").ServiceNamespace;
const Datapoint = @import("datapoint.zig").Datapoint;

pub const GetScalingPlanResourceForecastDataInput = struct {
    /// The exclusive end time of the time range for the forecast data to get. The
    /// maximum time
    /// duration between the start and end time is seven days.
    ///
    /// Although this parameter can accept a date and time that is more than two
    /// days in the
    /// future, the availability of forecast data has limits. AWS Auto Scaling only
    /// issues forecasts for
    /// periods of two days in advance.
    end_time: i64,

    /// The type of forecast data to get.
    ///
    /// * `LoadForecast`: The load metric forecast.
    ///
    /// * `CapacityForecast`: The capacity forecast.
    ///
    /// * `ScheduledActionMinCapacity`: The minimum capacity for each scheduled
    /// scaling action. This data is calculated as the larger of two values: the
    /// capacity
    /// forecast or the minimum capacity in the scaling instruction.
    ///
    /// * `ScheduledActionMaxCapacity`: The maximum capacity for each scheduled
    /// scaling action. The calculation used is determined by the predictive scaling
    /// maximum
    /// capacity behavior setting in the scaling instruction.
    forecast_data_type: ForecastDataType,

    /// The ID of the resource. This string consists of a prefix
    /// (`autoScalingGroup`)
    /// followed by the name of a specified Auto Scaling group (`my-asg`). Example:
    /// `autoScalingGroup/my-asg`.
    resource_id: []const u8,

    /// The scalable dimension for the resource. The only valid value is
    /// `autoscaling:autoScalingGroup:DesiredCapacity`.
    scalable_dimension: ScalableDimension,

    /// The name of the scaling plan.
    scaling_plan_name: []const u8,

    /// The version number of the scaling plan. Currently, the only valid value is
    /// `1`.
    scaling_plan_version: i64,

    /// The namespace of the AWS service. The only valid value is `autoscaling`.
    service_namespace: ServiceNamespace,

    /// The inclusive start time of the time range for the forecast data to get. The
    /// date and
    /// time can be at most 56 days before the current date and time.
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .forecast_data_type = "ForecastDataType",
        .resource_id = "ResourceId",
        .scalable_dimension = "ScalableDimension",
        .scaling_plan_name = "ScalingPlanName",
        .scaling_plan_version = "ScalingPlanVersion",
        .service_namespace = "ServiceNamespace",
        .start_time = "StartTime",
    };
};

pub const GetScalingPlanResourceForecastDataOutput = struct {
    /// The data points to return.
    datapoints: ?[]const Datapoint = null,

    pub const json_field_names = .{
        .datapoints = "Datapoints",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetScalingPlanResourceForecastDataInput, options: CallOptions) !GetScalingPlanResourceForecastDataOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "autoscaling-plans", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetScalingPlanResourceForecastDataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("autoscaling-plans", "Auto Scaling Plans", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AnyScaleScalingPlannerFrontendService.GetScalingPlanResourceForecastData");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetScalingPlanResourceForecastDataOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetScalingPlanResourceForecastDataOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ConcurrentUpdateException")) {
        const parsed_error: ?errors.ConcurrentUpdateException = aws.json.parseJsonObject(errors.ConcurrentUpdateException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .concurrent_update_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalServiceException")) {
        const parsed_error: ?errors.InternalServiceException = aws.json.parseJsonObject(errors.InternalServiceException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_service_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        const parsed_error: ?errors.InvalidNextTokenException = aws.json.parseJsonObject(errors.InvalidNextTokenException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        const parsed_error: ?errors.LimitExceededException = aws.json.parseJsonObject(errors.LimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ObjectNotFoundException")) {
        const parsed_error: ?errors.ObjectNotFoundException = aws.json.parseJsonObject(errors.ObjectNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .object_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        const parsed_error: ?errors.ValidationException = aws.json.parseJsonObject(errors.ValidationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .validation_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
