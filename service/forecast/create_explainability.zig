const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DataSource = @import("data_source.zig").DataSource;
const ExplainabilityConfig = @import("explainability_config.zig").ExplainabilityConfig;
const Schema = @import("schema.zig").Schema;
const Tag = @import("tag.zig").Tag;

pub const CreateExplainabilityInput = struct {
    data_source: ?DataSource = null,

    /// Create an Explainability visualization that is viewable within the Amazon
    /// Web Services console.
    enable_visualization: ?bool = null,

    /// If `TimePointGranularity` is set to `SPECIFIC`, define the last
    /// time point for the Explainability.
    ///
    /// Use the following timestamp format: yyyy-MM-ddTHH:mm:ss (example:
    /// 2015-01-01T20:00:00)
    end_date_time: ?[]const u8 = null,

    /// The configuration settings that define the granularity of time series and
    /// time points
    /// for the Explainability.
    explainability_config: ExplainabilityConfig,

    /// A unique name for the Explainability.
    explainability_name: []const u8,

    /// The Amazon Resource Name (ARN) of the Predictor or Forecast used to create
    /// the
    /// Explainability.
    resource_arn: []const u8,

    schema: ?Schema = null,

    /// If `TimePointGranularity` is set to `SPECIFIC`, define the first
    /// point for the Explainability.
    ///
    /// Use the following timestamp format: yyyy-MM-ddTHH:mm:ss (example:
    /// 2015-01-01T20:00:00)
    start_date_time: ?[]const u8 = null,

    /// Optional metadata to help you categorize and organize your resources. Each
    /// tag
    /// consists of a key and an optional value, both of which you define. Tag keys
    /// and values
    /// are case sensitive.
    ///
    /// The following restrictions apply to tags:
    ///
    /// * For each resource, each tag key must be unique and each tag key must have
    ///   one
    /// value.
    ///
    /// * Maximum number of tags per resource: 50.
    ///
    /// * Maximum key length: 128 Unicode characters in UTF-8.
    ///
    /// * Maximum value length: 256 Unicode characters in UTF-8.
    ///
    /// * Accepted characters: all letters and numbers, spaces representable in
    ///   UTF-8,
    /// and + - = . _ : / @. If your tagging schema is used across other services
    /// and
    /// resources, the character restrictions of those services also apply.
    ///
    /// * Key prefixes cannot include any upper or lowercase combination of
    /// `aws:` or `AWS:`. Values can have this prefix. If a
    /// tag value has `aws` as its prefix but the key does not, Forecast
    /// considers it to be a user tag and will count against the limit of 50 tags.
    /// Tags
    /// with only the key prefix of `aws` do not count against your tags per
    /// resource limit. You cannot edit or delete tag keys with this prefix.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .data_source = "DataSource",
        .enable_visualization = "EnableVisualization",
        .end_date_time = "EndDateTime",
        .explainability_config = "ExplainabilityConfig",
        .explainability_name = "ExplainabilityName",
        .resource_arn = "ResourceArn",
        .schema = "Schema",
        .start_date_time = "StartDateTime",
        .tags = "Tags",
    };
};

pub const CreateExplainabilityOutput = struct {
    /// The Amazon Resource Name (ARN) of the Explainability.
    explainability_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .explainability_arn = "ExplainabilityArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateExplainabilityInput, options: Options) !CreateExplainabilityOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateExplainabilityInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonForecast.CreateExplainability");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateExplainabilityOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateExplainabilityOutput, body, allocator);
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
