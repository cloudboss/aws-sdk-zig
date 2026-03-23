const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const DatasetType = @import("dataset_type.zig").DatasetType;
const Domain = @import("domain.zig").Domain;
const EncryptionConfig = @import("encryption_config.zig").EncryptionConfig;
const Schema = @import("schema.zig").Schema;
const Tag = @import("tag.zig").Tag;

pub const CreateDatasetInput = struct {
    /// The frequency of data collection. This parameter is required for
    /// RELATED_TIME_SERIES
    /// datasets.
    ///
    /// Valid intervals are an integer followed by Y (Year), M (Month), W (Week), D
    /// (Day), H (Hour), and min (Minute). For example,
    /// "1D" indicates every day and "15min" indicates every 15 minutes. You cannot
    /// specify a value that would overlap with the next larger frequency. That
    /// means, for example, you cannot specify a frequency of 60 minutes, because
    /// that is equivalent to 1 hour. The valid values for each frequency are the
    /// following:
    ///
    /// * Minute - 1-59
    ///
    /// * Hour - 1-23
    ///
    /// * Day - 1-6
    ///
    /// * Week - 1-4
    ///
    /// * Month - 1-11
    ///
    /// * Year - 1
    ///
    /// Thus, if you want every other week forecasts, specify "2W". Or, if you want
    /// quarterly forecasts, you specify "3M".
    data_frequency: ?[]const u8 = null,

    /// A name for the dataset.
    dataset_name: []const u8,

    /// The dataset type. Valid values depend on the chosen `Domain`.
    dataset_type: DatasetType,

    /// The domain associated with the dataset. When you add a dataset to a dataset
    /// group, this
    /// value and the value specified for the `Domain` parameter of the
    /// [CreateDatasetGroup](https://docs.aws.amazon.com/forecast/latest/dg/API_CreateDatasetGroup.html) operation must match.
    ///
    /// The `Domain` and `DatasetType` that you choose determine the fields
    /// that must be present in the training data that you import to the dataset.
    /// For example, if you
    /// choose the `RETAIL` domain and `TARGET_TIME_SERIES` as the
    /// `DatasetType`, Amazon Forecast requires `item_id`, `timestamp`,
    /// and `demand` fields to be present in your data. For more information, see
    /// [Importing
    /// datasets](https://docs.aws.amazon.com/forecast/latest/dg/howitworks-datasets-groups.html).
    domain: Domain,

    /// An Key Management Service (KMS) key and the Identity and Access Management
    /// (IAM) role that Amazon Forecast can assume to access
    /// the key.
    encryption_config: ?EncryptionConfig = null,

    /// The schema for the dataset. The schema attributes and their order must match
    /// the fields in
    /// your data. The dataset `Domain` and `DatasetType` that you choose
    /// determine the minimum required fields in your training data. For information
    /// about the
    /// required fields for a specific dataset domain and type, see [Dataset Domains
    /// and Dataset
    /// Types](https://docs.aws.amazon.com/forecast/latest/dg/howitworks-domains-ds-types.html).
    schema: Schema,

    /// The optional metadata that you apply to the dataset to help you categorize
    /// and organize
    /// them. Each tag consists of a key and an optional value, both of which you
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
        .data_frequency = "DataFrequency",
        .dataset_name = "DatasetName",
        .dataset_type = "DatasetType",
        .domain = "Domain",
        .encryption_config = "EncryptionConfig",
        .schema = "Schema",
        .tags = "Tags",
    };
};

pub const CreateDatasetOutput = struct {
    /// The Amazon Resource Name (ARN) of the dataset.
    dataset_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .dataset_arn = "DatasetArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDatasetInput, options: CallOptions) !CreateDatasetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDatasetInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonForecast.CreateDataset");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDatasetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateDatasetOutput, body, allocator);
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
