const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DataDestination = @import("data_destination.zig").DataDestination;
const Tag = @import("tag.zig").Tag;

pub const CreateForecastExportJobInput = struct {
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

    /// The Amazon Resource Name (ARN) of the forecast that you want to export.
    forecast_arn: []const u8,

    /// The name for the forecast export job.
    forecast_export_job_name: []const u8,

    /// The format of the exported data, CSV or PARQUET. The default value is CSV.
    format: ?[]const u8 = null,

    /// The optional metadata that you apply to the forecast export job to help you
    /// categorize and
    /// organize them. Each tag consists of a key and an optional value, both of
    /// which you
    /// define.
    ///
    /// The following basic restrictions apply to tags:
    ///
    /// * Maximum number of tags per resource - 50.
    ///
    /// * For each resource, each tag key must be unique, and each tag key can have
    ///   only one
    /// value.
    ///
    /// * Maximum key length - 128 Unicode characters in UTF-8.
    ///
    /// * Maximum value length - 256 Unicode characters in UTF-8.
    ///
    /// * If your tagging schema is used across multiple services and resources,
    ///   remember that
    /// other services may have restrictions on allowed characters. Generally
    /// allowed characters
    /// are: letters, numbers, and spaces representable in UTF-8, and the following
    /// characters: +
    /// - = . _ : / @.
    ///
    /// * Tag keys and values are case sensitive.
    ///
    /// * Do not use `aws:`, `AWS:`, or any upper or lowercase combination
    /// of such as a prefix for keys as it is reserved for Amazon Web Services use.
    /// You cannot edit or delete tag
    /// keys with this prefix. Values can have this prefix. If a tag value has `aws`
    /// as
    /// its prefix but the key does not, then Forecast considers it to be a user tag
    /// and will
    /// count against the limit of 50 tags. Tags with only the key prefix of `aws`
    /// do
    /// not count against your tags per resource limit.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .destination = "Destination",
        .forecast_arn = "ForecastArn",
        .forecast_export_job_name = "ForecastExportJobName",
        .format = "Format",
        .tags = "Tags",
    };
};

pub const CreateForecastExportJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the export job.
    forecast_export_job_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .forecast_export_job_arn = "ForecastExportJobArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateForecastExportJobInput, options: Options) !CreateForecastExportJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateForecastExportJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonForecast.CreateForecastExportJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateForecastExportJobOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateForecastExportJobOutput, body, allocator);
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
