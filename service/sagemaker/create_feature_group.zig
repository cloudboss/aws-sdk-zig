const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const FeatureDefinition = @import("feature_definition.zig").FeatureDefinition;
const OfflineStoreConfig = @import("offline_store_config.zig").OfflineStoreConfig;
const OnlineStoreConfig = @import("online_store_config.zig").OnlineStoreConfig;
const Tag = @import("tag.zig").Tag;
const ThroughputConfig = @import("throughput_config.zig").ThroughputConfig;

pub const CreateFeatureGroupInput = struct {
    /// A free-form description of a `FeatureGroup`.
    description: ?[]const u8 = null,

    /// The name of the feature that stores the `EventTime` of a `Record` in a
    /// `FeatureGroup`.
    ///
    /// An `EventTime` is a point in time when a new event occurs that corresponds
    /// to the creation or update of a `Record` in a `FeatureGroup`. All `Records`
    /// in the `FeatureGroup` must have a corresponding `EventTime`.
    ///
    /// An `EventTime` can be a `String` or `Fractional`.
    ///
    /// * `Fractional`: `EventTime` feature values must be a Unix timestamp in
    ///   seconds.
    /// * `String`: `EventTime` feature values must be an ISO-8601 string in the
    ///   format. The following formats are supported `yyyy-MM-dd'T'HH:mm:ssZ` and
    ///   `yyyy-MM-dd'T'HH:mm:ss.SSSZ` where `yyyy`, `MM`, and `dd` represent the
    ///   year, month, and day respectively and `HH`, `mm`, `ss`, and if applicable,
    ///   `SSS` represent the hour, month, second and milliseconds respsectively.
    ///   `'T'` and `Z` are constants.
    event_time_feature_name: []const u8,

    /// A list of `Feature` names and types. `Name` and `Type` is compulsory per
    /// `Feature`.
    ///
    /// Valid feature `FeatureType`s are `Integral`, `Fractional` and `String`.
    ///
    /// `FeatureName`s cannot be any of the following: `is_deleted`, `write_time`,
    /// `api_invocation_time`
    ///
    /// You can create up to 2,500 `FeatureDefinition`s per `FeatureGroup`.
    feature_definitions: []const FeatureDefinition,

    /// The name of the `FeatureGroup`. The name must be unique within an Amazon Web
    /// Services Region in an Amazon Web Services account.
    ///
    /// The name:
    ///
    /// * Must start with an alphanumeric character.
    /// * Can only include alphanumeric characters, underscores, and hyphens. Spaces
    ///   are not allowed.
    feature_group_name: []const u8,

    /// Use this to configure an `OfflineFeatureStore`. This parameter allows you to
    /// specify:
    ///
    /// * The Amazon Simple Storage Service (Amazon S3) location of an
    ///   `OfflineStore`.
    /// * A configuration for an Amazon Web Services Glue or Amazon Web Services
    ///   Hive data catalog.
    /// * An KMS encryption key to encrypt the Amazon S3 location used for
    ///   `OfflineStore`. If KMS encryption key is not specified, by default we
    ///   encrypt all data at rest using Amazon Web Services KMS key. By defining
    ///   your [bucket-level
    ///   key](https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucket-key.html) for SSE, you can reduce Amazon Web Services KMS requests costs by up to 99 percent.
    /// * Format for the offline store table. Supported formats are Glue (Default)
    ///   and [Apache Iceberg](https://iceberg.apache.org/).
    ///
    /// To learn more about this parameter, see
    /// [OfflineStoreConfig](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_OfflineStoreConfig.html).
    offline_store_config: ?OfflineStoreConfig = null,

    /// You can turn the `OnlineStore` on or off by specifying `True` for the
    /// `EnableOnlineStore` flag in `OnlineStoreConfig`.
    ///
    /// You can also include an Amazon Web Services KMS key ID (`KMSKeyId`) for
    /// at-rest encryption of the `OnlineStore`.
    ///
    /// The default value is `False`.
    online_store_config: ?OnlineStoreConfig = null,

    /// The name of the `Feature` whose value uniquely identifies a `Record` defined
    /// in the `FeatureStore`. Only the latest record per identifier value will be
    /// stored in the `OnlineStore`. `RecordIdentifierFeatureName` must be one of
    /// feature definitions' names.
    ///
    /// You use the `RecordIdentifierFeatureName` to access data in a
    /// `FeatureStore`.
    ///
    /// This name:
    ///
    /// * Must start with an alphanumeric character.
    /// * Can only contains alphanumeric characters, hyphens, underscores. Spaces
    ///   are not allowed.
    record_identifier_feature_name: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM execution role used to persist
    /// data into the `OfflineStore` if an `OfflineStoreConfig` is provided.
    role_arn: ?[]const u8 = null,

    /// Tags used to identify `Features` in each `FeatureGroup`.
    tags: ?[]const Tag = null,

    throughput_config: ?ThroughputConfig = null,

    pub const json_field_names = .{
        .description = "Description",
        .event_time_feature_name = "EventTimeFeatureName",
        .feature_definitions = "FeatureDefinitions",
        .feature_group_name = "FeatureGroupName",
        .offline_store_config = "OfflineStoreConfig",
        .online_store_config = "OnlineStoreConfig",
        .record_identifier_feature_name = "RecordIdentifierFeatureName",
        .role_arn = "RoleArn",
        .tags = "Tags",
        .throughput_config = "ThroughputConfig",
    };
};

pub const CreateFeatureGroupOutput = struct {
    /// The Amazon Resource Name (ARN) of the `FeatureGroup`. This is a unique
    /// identifier for the feature group.
    feature_group_arn: []const u8,

    pub const json_field_names = .{
        .feature_group_arn = "FeatureGroupArn",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFeatureGroupInput, options: Options) !CreateFeatureGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemaker");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateFeatureGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker", "SageMaker", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "SageMaker.CreateFeatureGroup");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateFeatureGroupOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateFeatureGroupOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUse")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found = .{
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
