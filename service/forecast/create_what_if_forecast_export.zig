const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataDestination = @import("data_destination.zig").DataDestination;
const Tag = @import("tag.zig").Tag;

pub const CreateWhatIfForecastExportInput = struct {
    /// The location where you want to save the forecast and an Identity and Access
    /// Management (IAM) role that
    /// Amazon Forecast can assume to access the location. The forecast must be
    /// exported to an Amazon S3
    /// bucket.
    ///
    /// If encryption is used, `Destination` must include an Key Management Service
    /// (KMS) key. The
    /// IAM role must allow Amazon Forecast permission to access the key.
    destination: DataDestination,

    /// The format of the exported data, CSV or PARQUET.
    format: ?[]const u8 = null,

    /// A list of
    /// [tags](https://docs.aws.amazon.com/forecast/latest/dg/tagging-forecast-resources.html) to apply to the what if forecast.
    tags: ?[]const Tag = null,

    /// The list of what-if forecast Amazon Resource Names (ARNs) to export.
    what_if_forecast_arns: []const []const u8,

    /// The name of the what-if forecast to export.
    what_if_forecast_export_name: []const u8,

    pub const json_field_names = .{
        .destination = "Destination",
        .format = "Format",
        .tags = "Tags",
        .what_if_forecast_arns = "WhatIfForecastArns",
        .what_if_forecast_export_name = "WhatIfForecastExportName",
    };
};

pub const CreateWhatIfForecastExportOutput = struct {
    /// The Amazon Resource Name (ARN) of the what-if forecast.
    what_if_forecast_export_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .what_if_forecast_export_arn = "WhatIfForecastExportArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWhatIfForecastExportInput, options: CallOptions) !CreateWhatIfForecastExportOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "forecast", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateWhatIfForecastExportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("forecast", "forecast", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonForecast.CreateWhatIfForecastExport");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateWhatIfForecastExportOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateWhatIfForecastExportOutput, body, allocator);
}
