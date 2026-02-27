const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const FeatureDefinition = @import("feature_definition.zig").FeatureDefinition;
const FeatureGroupStatus = @import("feature_group_status.zig").FeatureGroupStatus;
const LastUpdateStatus = @import("last_update_status.zig").LastUpdateStatus;
const OfflineStoreConfig = @import("offline_store_config.zig").OfflineStoreConfig;
const OfflineStoreStatus = @import("offline_store_status.zig").OfflineStoreStatus;
const OnlineStoreConfig = @import("online_store_config.zig").OnlineStoreConfig;
const ThroughputConfigDescription = @import("throughput_config_description.zig").ThroughputConfigDescription;

pub const DescribeFeatureGroupInput = struct {
    /// The name or Amazon Resource Name (ARN) of the `FeatureGroup` you want
    /// described.
    feature_group_name: []const u8,

    /// A token to resume pagination of the list of `Features`
    /// (`FeatureDefinitions`). 2,500 `Features` are returned by default.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .feature_group_name = "FeatureGroupName",
        .next_token = "NextToken",
    };
};

pub const DescribeFeatureGroupOutput = struct {
    /// A timestamp indicating when SageMaker created the `FeatureGroup`.
    creation_time: i64,

    /// A free form description of the feature group.
    description: ?[]const u8 = null,

    /// The name of the feature that stores the `EventTime` of a Record in a
    /// `FeatureGroup`.
    ///
    /// An `EventTime` is a point in time when a new event occurs that corresponds
    /// to the creation or update of a `Record` in a `FeatureGroup`. All `Records`
    /// in the `FeatureGroup` have a corresponding `EventTime`.
    event_time_feature_name: []const u8,

    /// The reason that the `FeatureGroup` failed to be replicated in the
    /// `OfflineStore`. This is failure can occur because:
    ///
    /// * The `FeatureGroup` could not be created in the `OfflineStore`.
    /// * The `FeatureGroup` could not be deleted from the `OfflineStore`.
    failure_reason: ?[]const u8 = null,

    /// A list of the `Features` in the `FeatureGroup`. Each feature is defined by a
    /// `FeatureName` and `FeatureType`.
    feature_definitions: ?[]const FeatureDefinition = null,

    /// The Amazon Resource Name (ARN) of the `FeatureGroup`.
    feature_group_arn: []const u8,

    /// he name of the `FeatureGroup`.
    feature_group_name: []const u8,

    /// The status of the feature group.
    feature_group_status: ?FeatureGroupStatus = null,

    /// A timestamp indicating when the feature group was last updated.
    last_modified_time: ?i64 = null,

    /// A value indicating whether the update made to the feature group was
    /// successful.
    last_update_status: ?LastUpdateStatus = null,

    /// A token to resume pagination of the list of `Features`
    /// (`FeatureDefinitions`).
    next_token: []const u8,

    /// The configuration of the offline store. It includes the following
    /// configurations:
    ///
    /// * Amazon S3 location of the offline store.
    /// * Configuration of the Glue data catalog.
    /// * Table format of the offline store.
    /// * Option to disable the automatic creation of a Glue table for the offline
    ///   store.
    /// * Encryption configuration.
    offline_store_config: ?OfflineStoreConfig = null,

    /// The status of the `OfflineStore`. Notifies you if replicating data into the
    /// `OfflineStore` has failed. Returns either: `Active` or `Blocked`
    offline_store_status: ?OfflineStoreStatus = null,

    /// The configuration for the `OnlineStore`.
    online_store_config: ?OnlineStoreConfig = null,

    /// The size of the `OnlineStore` in bytes.
    online_store_total_size_bytes: ?i64 = null,

    /// The name of the `Feature` used for `RecordIdentifier`, whose value uniquely
    /// identifies a record stored in the feature store.
    record_identifier_feature_name: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM execution role used to persist
    /// data into the OfflineStore if an OfflineStoreConfig is provided.
    role_arn: ?[]const u8 = null,

    throughput_config: ?ThroughputConfigDescription = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .description = "Description",
        .event_time_feature_name = "EventTimeFeatureName",
        .failure_reason = "FailureReason",
        .feature_definitions = "FeatureDefinitions",
        .feature_group_arn = "FeatureGroupArn",
        .feature_group_name = "FeatureGroupName",
        .feature_group_status = "FeatureGroupStatus",
        .last_modified_time = "LastModifiedTime",
        .last_update_status = "LastUpdateStatus",
        .next_token = "NextToken",
        .offline_store_config = "OfflineStoreConfig",
        .offline_store_status = "OfflineStoreStatus",
        .online_store_config = "OnlineStoreConfig",
        .online_store_total_size_bytes = "OnlineStoreTotalSizeBytes",
        .record_identifier_feature_name = "RecordIdentifierFeatureName",
        .role_arn = "RoleArn",
        .throughput_config = "ThroughputConfig",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeFeatureGroupInput, options: Options) !DescribeFeatureGroupOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeFeatureGroupInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "SageMaker.DescribeFeatureGroup");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeFeatureGroupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeFeatureGroupOutput, body, alloc);
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
