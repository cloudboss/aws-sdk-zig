const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Forecast = @import("forecast.zig").Forecast;

pub const QueryWhatIfForecastInput = struct {
    /// The end date for the what-if forecast. Specify the date using this format:
    /// yyyy-MM-dd'T'HH:mm:ss
    /// (ISO 8601 format). For example, 2015-01-01T20:00:00.
    end_date: ?[]const u8 = null,

    /// The filtering criteria to apply when retrieving the forecast. For example,
    /// to get the
    /// forecast for `client_21` in the electricity usage dataset, specify the
    /// following:
    ///
    /// `{"item_id" : "client_21"}`
    ///
    /// To get the full what-if forecast, use the
    /// [CreateForecastExportJob](https://docs.aws.amazon.com/en_us/forecast/latest/dg/API_CreateWhatIfForecastExport.html) operation.
    filters: []const aws.map.StringMapEntry,

    /// If the result of the previous request was truncated, the response includes a
    /// `NextToken`. To retrieve the next set of results, use the token in the next
    /// request. Tokens expire after 24 hours.
    next_token: ?[]const u8 = null,

    /// The start date for the what-if forecast. Specify the date using this format:
    /// yyyy-MM-dd'T'HH:mm:ss
    /// (ISO 8601 format). For example, 2015-01-01T08:00:00.
    start_date: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the what-if forecast to query.
    what_if_forecast_arn: []const u8,

    pub const json_field_names = .{
        .end_date = "EndDate",
        .filters = "Filters",
        .next_token = "NextToken",
        .start_date = "StartDate",
        .what_if_forecast_arn = "WhatIfForecastArn",
    };
};

pub const QueryWhatIfForecastOutput = struct {
    forecast: ?Forecast = null,

    pub const json_field_names = .{
        .forecast = "Forecast",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: QueryWhatIfForecastInput, options: Options) !QueryWhatIfForecastOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "forecastquery");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: QueryWhatIfForecastInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("forecastquery", "forecastquery", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonForecastRuntime.QueryWhatIfForecast");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !QueryWhatIfForecastOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(QueryWhatIfForecastOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
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

    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        return .{ .arena = arena, .kind = .{ .invalid_input_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
