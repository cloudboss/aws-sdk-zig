const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DatasetType = @import("dataset_type.zig").DatasetType;
const Domain = @import("domain.zig").Domain;
const EncryptionConfig = @import("encryption_config.zig").EncryptionConfig;
const Schema = @import("schema.zig").Schema;

pub const DescribeDatasetInput = struct {
    /// The Amazon Resource Name (ARN) of the dataset.
    dataset_arn: []const u8,

    pub const json_field_names = .{
        .dataset_arn = "DatasetArn",
    };
};

pub const DescribeDatasetOutput = struct {
    /// When the dataset was created.
    creation_time: ?i64 = null,

    /// The frequency of data collection.
    ///
    /// Valid intervals are Y (Year), M (Month), W (Week), D (Day), H (Hour), 30min
    /// (30 minutes),
    /// 15min (15 minutes), 10min (10 minutes), 5min (5 minutes), and 1min (1
    /// minute). For example,
    /// "M" indicates every month and "30min" indicates every 30 minutes.
    data_frequency: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the dataset.
    dataset_arn: ?[]const u8 = null,

    /// The name of the dataset.
    dataset_name: ?[]const u8 = null,

    /// The dataset type.
    dataset_type: ?DatasetType = null,

    /// The domain associated with the dataset.
    domain: ?Domain = null,

    /// The Key Management Service (KMS) key and the Identity and Access Management
    /// (IAM) role that Amazon Forecast can assume to access
    /// the key.
    encryption_config: ?EncryptionConfig = null,

    /// When you create a dataset, `LastModificationTime` is the same as
    /// `CreationTime`. While data is being imported to the dataset,
    /// `LastModificationTime` is the current time of the `DescribeDataset`
    /// call. After a
    /// [CreateDatasetImportJob](https://docs.aws.amazon.com/forecast/latest/dg/API_CreateDatasetImportJob.html)
    /// operation has finished, `LastModificationTime` is when the import job
    /// completed or
    /// failed.
    last_modification_time: ?i64 = null,

    /// An array of `SchemaAttribute` objects that specify the dataset fields. Each
    /// `SchemaAttribute` specifies the name and data type of a field.
    schema: ?Schema = null,

    /// The status of the dataset. States include:
    ///
    /// * `ACTIVE`
    ///
    /// * `CREATE_PENDING`, `CREATE_IN_PROGRESS`,
    /// `CREATE_FAILED`
    ///
    /// * `DELETE_PENDING`, `DELETE_IN_PROGRESS`,
    /// `DELETE_FAILED`
    ///
    /// * `UPDATE_PENDING`, `UPDATE_IN_PROGRESS`,
    /// `UPDATE_FAILED`
    ///
    /// The `UPDATE` states apply while data is imported to the dataset from a call
    /// to
    /// the
    /// [CreateDatasetImportJob](https://docs.aws.amazon.com/forecast/latest/dg/API_CreateDatasetImportJob.html) operation and reflect the status of the dataset import job.
    /// For example, when the import job status is `CREATE_IN_PROGRESS`, the status
    /// of the
    /// dataset is `UPDATE_IN_PROGRESS`.
    ///
    /// The `Status` of the dataset must be `ACTIVE` before you can import
    /// training data.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .data_frequency = "DataFrequency",
        .dataset_arn = "DatasetArn",
        .dataset_name = "DatasetName",
        .dataset_type = "DatasetType",
        .domain = "Domain",
        .encryption_config = "EncryptionConfig",
        .last_modification_time = "LastModificationTime",
        .schema = "Schema",
        .status = "Status",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDatasetInput, options: Options) !DescribeDatasetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDatasetInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonForecast.DescribeDataset");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDatasetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeDatasetOutput, body, allocator);
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
