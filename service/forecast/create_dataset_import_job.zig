const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DataSource = @import("data_source.zig").DataSource;
const ImportMode = @import("import_mode.zig").ImportMode;
const Tag = @import("tag.zig").Tag;

pub const CreateDatasetImportJobInput = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Forecast dataset that you want
    /// to import data
    /// to.
    dataset_arn: []const u8,

    /// The name for the dataset import job. We recommend including the current
    /// timestamp in the
    /// name, for example, `20190721DatasetImport`. This can help you avoid getting
    /// a
    /// `ResourceAlreadyExistsException` exception.
    dataset_import_job_name: []const u8,

    /// The location of the training data to import and an Identity and Access
    /// Management (IAM) role that Amazon Forecast
    /// can assume to access the data. The training data must be stored in an Amazon
    /// S3 bucket.
    ///
    /// If encryption is used, `DataSource` must include an Key Management Service
    /// (KMS) key and the
    /// IAM role must allow Amazon Forecast permission to access the key. The KMS
    /// key and IAM role must
    /// match those specified in the `EncryptionConfig` parameter of the
    /// [CreateDataset](https://docs.aws.amazon.com/forecast/latest/dg/API_CreateDataset.html)
    /// operation.
    data_source: DataSource,

    /// The format of the imported data, CSV or PARQUET. The default value is CSV.
    format: ?[]const u8 = null,

    /// The format of the geolocation attribute. The geolocation attribute can be
    /// formatted in
    /// one of two ways:
    ///
    /// * `LAT_LONG` - the latitude and longitude in decimal format (Example:
    ///   47.61_-122.33).
    ///
    /// * `CC_POSTALCODE` (US Only) - the country code (US), followed by the 5-digit
    ///   ZIP code (Example: US_98121).
    geolocation_format: ?[]const u8 = null,

    /// Specifies whether the dataset import job is a `FULL` or `INCREMENTAL`
    /// import. A `FULL` dataset import replaces all of the existing data with the
    /// newly imported data. An `INCREMENTAL` import appends the imported data to
    /// the existing data.
    import_mode: ?ImportMode = null,

    /// The optional metadata that you apply to the dataset import job to help you
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
    ///
    /// If the format isn't specified, Amazon Forecast expects the format to be
    /// "yyyy-MM-dd
    /// HH:mm:ss".
    timestamp_format: ?[]const u8 = null,

    /// A single time zone for every item in your dataset. This option is ideal for
    /// datasets
    /// with all timestamps within a single time zone, or if all timestamps are
    /// normalized to a
    /// single time zone.
    ///
    /// Refer to the [Joda-Time
    /// API](http://joda-time.sourceforge.net/timezones.html) for a complete list of
    /// valid time zone names.
    time_zone: ?[]const u8 = null,

    /// Automatically derive time zone information from the geolocation attribute.
    /// This option
    /// is ideal for datasets that contain timestamps in multiple time zones and
    /// those
    /// timestamps are expressed in local time.
    use_geolocation_for_time_zone: ?bool = null,

    pub const json_field_names = .{
        .dataset_arn = "DatasetArn",
        .dataset_import_job_name = "DatasetImportJobName",
        .data_source = "DataSource",
        .format = "Format",
        .geolocation_format = "GeolocationFormat",
        .import_mode = "ImportMode",
        .tags = "Tags",
        .timestamp_format = "TimestampFormat",
        .time_zone = "TimeZone",
        .use_geolocation_for_time_zone = "UseGeolocationForTimeZone",
    };
};

pub const CreateDatasetImportJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the dataset import job.
    dataset_import_job_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .dataset_import_job_arn = "DatasetImportJobArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDatasetImportJobInput, options: Options) !CreateDatasetImportJobOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateDatasetImportJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "AmazonForecast.CreateDatasetImportJob");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateDatasetImportJobOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateDatasetImportJobOutput, body, alloc);
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
