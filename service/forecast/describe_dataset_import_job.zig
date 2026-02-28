const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DataSource = @import("data_source.zig").DataSource;
const Statistics = @import("statistics.zig").Statistics;
const ImportMode = @import("import_mode.zig").ImportMode;

pub const DescribeDatasetImportJobInput = struct {
    /// The Amazon Resource Name (ARN) of the dataset import job.
    dataset_import_job_arn: []const u8,

    pub const json_field_names = .{
        .dataset_import_job_arn = "DatasetImportJobArn",
    };
};

pub const DescribeDatasetImportJobOutput = struct {
    /// When the dataset import job was created.
    creation_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the dataset that the training data was
    /// imported
    /// to.
    dataset_arn: ?[]const u8 = null,

    /// The ARN of the dataset import job.
    dataset_import_job_arn: ?[]const u8 = null,

    /// The name of the dataset import job.
    dataset_import_job_name: ?[]const u8 = null,

    /// The size of the dataset in gigabytes (GB) after the import job has finished.
    data_size: ?f64 = null,

    /// The location of the training data to import and an Identity and Access
    /// Management (IAM) role that Amazon Forecast
    /// can assume to access the data.
    ///
    /// If encryption is used, `DataSource` includes an Key Management Service (KMS)
    /// key.
    data_source: ?DataSource = null,

    /// The estimated time remaining in minutes for the dataset import job to
    /// complete.
    estimated_time_remaining_in_minutes: ?i64 = null,

    /// Statistical information about each field in the input data.
    field_statistics: ?[]const aws.map.MapEntry(Statistics) = null,

    /// The format of the imported data, CSV or PARQUET.
    format: ?[]const u8 = null,

    /// The format of the geolocation attribute. Valid Values:`"LAT_LONG"` and
    /// `"CC_POSTALCODE"`.
    geolocation_format: ?[]const u8 = null,

    /// The import mode of the dataset import job, FULL or INCREMENTAL.
    import_mode: ?ImportMode = null,

    /// The last time the resource was modified. The timestamp depends on the status
    /// of the
    /// job:
    ///
    /// * `CREATE_PENDING` - The `CreationTime`.
    ///
    /// * `CREATE_IN_PROGRESS` - The current timestamp.
    ///
    /// * `CREATE_STOPPING` - The current timestamp.
    ///
    /// * `CREATE_STOPPED` - When the job stopped.
    ///
    /// * `ACTIVE` or `CREATE_FAILED` - When the job finished or
    /// failed.
    last_modification_time: ?i64 = null,

    /// If an error occurred, an informational message about the error.
    message: ?[]const u8 = null,

    /// The status of the dataset import job. States include:
    ///
    /// * `ACTIVE`
    ///
    /// * `CREATE_PENDING`, `CREATE_IN_PROGRESS`,
    /// `CREATE_FAILED`
    ///
    /// * `DELETE_PENDING`, `DELETE_IN_PROGRESS`,
    /// `DELETE_FAILED`
    ///
    /// * `CREATE_STOPPING`, `CREATE_STOPPED`
    status: ?[]const u8 = null,

    /// The format of timestamps in the dataset. The format that you specify depends
    /// on the
    /// `DataFrequency` specified when the dataset was created. The following
    /// formats are
    /// supported
    ///
    /// * "yyyy-MM-dd"
    ///
    /// For the following data frequencies: Y, M, W, and D
    ///
    /// * "yyyy-MM-dd HH:mm:ss"
    ///
    /// For the following data frequencies: H, 30min, 15min, and 1min; and
    /// optionally, for: Y,
    /// M, W, and D
    timestamp_format: ?[]const u8 = null,

    /// The single time zone applied to every item in the dataset
    time_zone: ?[]const u8 = null,

    /// Whether `TimeZone` is automatically derived from the geolocation
    /// attribute.
    use_geolocation_for_time_zone: ?bool = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .dataset_arn = "DatasetArn",
        .dataset_import_job_arn = "DatasetImportJobArn",
        .dataset_import_job_name = "DatasetImportJobName",
        .data_size = "DataSize",
        .data_source = "DataSource",
        .estimated_time_remaining_in_minutes = "EstimatedTimeRemainingInMinutes",
        .field_statistics = "FieldStatistics",
        .format = "Format",
        .geolocation_format = "GeolocationFormat",
        .import_mode = "ImportMode",
        .last_modification_time = "LastModificationTime",
        .message = "Message",
        .status = "Status",
        .timestamp_format = "TimestampFormat",
        .time_zone = "TimeZone",
        .use_geolocation_for_time_zone = "UseGeolocationForTimeZone",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDatasetImportJobInput, options: Options) !DescribeDatasetImportJobOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeDatasetImportJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("forecast", "forecast", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "AmazonForecast.DescribeDatasetImportJob");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeDatasetImportJobOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeDatasetImportJobOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
