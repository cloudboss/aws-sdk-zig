const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Tag = @import("tag.zig").Tag;
const TimeSeriesReplacementsDataSource = @import("time_series_replacements_data_source.zig").TimeSeriesReplacementsDataSource;
const TimeSeriesTransformation = @import("time_series_transformation.zig").TimeSeriesTransformation;

pub const CreateWhatIfForecastInput = struct {
    /// A list of
    /// [tags](https://docs.aws.amazon.com/forecast/latest/dg/tagging-forecast-resources.html) to apply to the what if forecast.
    tags: ?[]const Tag = null,

    /// The replacement time series dataset, which contains the rows that you want
    /// to change in the related time
    /// series dataset. A replacement time series does not need to contain all rows
    /// that are in the baseline related time
    /// series. Include only the rows (measure-dimension combinations) that you want
    /// to include in the what-if
    /// forecast.
    ///
    /// This dataset is merged with the
    /// original time series to create a transformed dataset that is used for the
    /// what-if analysis.
    ///
    /// This dataset should contain the items to modify (such as item_id or
    /// workforce_type), any relevant dimensions, the timestamp column, and at least
    /// one of the related time series columns. This file should not contain
    /// duplicate timestamps for the same time series.
    ///
    /// Timestamps and item_ids not included in this dataset are not included in the
    /// what-if analysis.
    time_series_replacements_data_source: ?TimeSeriesReplacementsDataSource = null,

    /// The transformations that are applied to the baseline time series. Each
    /// transformation contains an action and a set of conditions. An action is
    /// applied only when all conditions are met. If no conditions are provided, the
    /// action is applied to all items.
    time_series_transformations: ?[]const TimeSeriesTransformation = null,

    /// The Amazon Resource Name (ARN) of the what-if analysis.
    what_if_analysis_arn: []const u8,

    /// The name of the what-if forecast. Names must be unique within each what-if
    /// analysis.
    what_if_forecast_name: []const u8,

    pub const json_field_names = .{
        .tags = "Tags",
        .time_series_replacements_data_source = "TimeSeriesReplacementsDataSource",
        .time_series_transformations = "TimeSeriesTransformations",
        .what_if_analysis_arn = "WhatIfAnalysisArn",
        .what_if_forecast_name = "WhatIfForecastName",
    };
};

pub const CreateWhatIfForecastOutput = struct {
    /// The Amazon Resource Name (ARN) of the what-if forecast.
    what_if_forecast_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .what_if_forecast_arn = "WhatIfForecastArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWhatIfForecastInput, options: CallOptions) !CreateWhatIfForecastOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "forecast");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateWhatIfForecastInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("forecast", "forecast", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonForecast.CreateWhatIfForecast");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateWhatIfForecastOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateWhatIfForecastOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
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
