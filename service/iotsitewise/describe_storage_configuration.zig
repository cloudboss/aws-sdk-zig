const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ConfigurationStatus = @import("configuration_status.zig").ConfigurationStatus;
const DisassociatedDataStorageState = @import("disassociated_data_storage_state.zig").DisassociatedDataStorageState;
const MultiLayerStorage = @import("multi_layer_storage.zig").MultiLayerStorage;
const RetentionPeriod = @import("retention_period.zig").RetentionPeriod;
const StorageType = @import("storage_type.zig").StorageType;
const WarmTierState = @import("warm_tier_state.zig").WarmTierState;
const WarmTierRetentionPeriod = @import("warm_tier_retention_period.zig").WarmTierRetentionPeriod;

pub const DescribeStorageConfigurationInput = struct {
};

pub const DescribeStorageConfigurationOutput = struct {
    configuration_status: ?ConfigurationStatus = null,

    /// Describes the configuration for ingesting NULL and NaN data. By default the
    /// feature is
    /// allowed. The feature is disallowed if the value is `true`.
    disallow_ingest_null_na_n: ?bool = null,

    /// Contains the storage configuration for time series (data streams) that
    /// aren't associated with asset properties.
    /// The `disassociatedDataStorage` can be one of the following values:
    ///
    /// * `ENABLED` – IoT SiteWise accepts time series that aren't associated with
    ///   asset properties.
    ///
    /// After the `disassociatedDataStorage` is enabled, you can't disable it.
    ///
    /// * `DISABLED` – IoT SiteWise doesn't accept time series (data streams) that
    ///   aren't associated with asset properties.
    ///
    /// For more information, see [Data
    /// streams](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/data-streams.html)
    /// in the *IoT SiteWise User Guide*.
    disassociated_data_storage: ?DisassociatedDataStorageState = null,

    /// The date the storage configuration was last updated, in Unix epoch time.
    last_update_date: ?i64 = null,

    /// Contains information about the storage destination.
    multi_layer_storage: ?MultiLayerStorage = null,

    /// The number of days your data is kept in the hot tier. By default, your data
    /// is kept indefinitely in the hot tier.
    retention_period: ?RetentionPeriod = null,

    /// The storage tier that you specified for your data.
    /// The `storageType` parameter can be one of the following values:
    ///
    /// * `SITEWISE_DEFAULT_STORAGE` – IoT SiteWise saves your data into the hot
    ///   tier.
    /// The hot tier is a service-managed database.
    ///
    /// * `MULTI_LAYER_STORAGE` – IoT SiteWise saves your data in both the cold tier
    ///   and the hot tier.
    /// The cold tier is a customer-managed Amazon S3 bucket.
    storage_type: StorageType,

    /// A service managed storage tier optimized for analytical queries. It stores
    /// periodically uploaded, buffered and historical data ingested with the
    /// CreaeBulkImportJob API.
    warm_tier: ?WarmTierState = null,

    /// Set this period to specify how long your data is stored in the warm tier
    /// before it is deleted. You can set this only if cold tier is enabled.
    warm_tier_retention_period: ?WarmTierRetentionPeriod = null,

    pub const json_field_names = .{
        .configuration_status = "configurationStatus",
        .disallow_ingest_null_na_n = "disallowIngestNullNaN",
        .disassociated_data_storage = "disassociatedDataStorage",
        .last_update_date = "lastUpdateDate",
        .multi_layer_storage = "multiLayerStorage",
        .retention_period = "retentionPeriod",
        .storage_type = "storageType",
        .warm_tier = "warmTier",
        .warm_tier_retention_period = "warmTierRetentionPeriod",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeStorageConfigurationInput, options: CallOptions) !DescribeStorageConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "iotsitewise");

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeStorageConfigurationInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/configuration/account/storage";

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeStorageConfigurationOutput {
    var result: DescribeStorageConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeStorageConfigurationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictingOperationException")) {
        return .{ .arena = arena, .kind = .{ .conflicting_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalFailureException")) {
        return .{ .arena = arena, .kind = .{ .internal_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
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
    if (std.mem.eql(u8, error_code, "PreconditionFailedException")) {
        return .{ .arena = arena, .kind = .{ .precondition_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "QueryTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .query_timeout_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
