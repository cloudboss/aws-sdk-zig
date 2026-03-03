const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const FeatureValue = @import("feature_value.zig").FeatureValue;
const TargetStore = @import("target_store.zig").TargetStore;
const TtlDuration = @import("ttl_duration.zig").TtlDuration;

pub const PutRecordInput = struct {
    /// The name or Amazon Resource Name (ARN) of the feature group that you want to
    /// insert the
    /// record into.
    feature_group_name: []const u8,

    /// List of FeatureValues to be inserted. This will be a full over-write. If you
    /// only want
    /// to update few of the feature values, do the following:
    ///
    /// * Use `GetRecord` to retrieve the latest record.
    ///
    /// * Update the record returned from `GetRecord`.
    ///
    /// * Use `PutRecord` to update feature values.
    record: []const FeatureValue,

    /// A list of stores to which you're adding the record. By default, Feature
    /// Store adds the
    /// record to all of the stores that you're using for the `FeatureGroup`.
    target_stores: ?[]const TargetStore = null,

    /// Time to live duration, where the record is hard deleted after the expiration
    /// time is
    /// reached; `ExpiresAt` = `EventTime` + `TtlDuration`. For
    /// information on HardDelete, see the
    /// [DeleteRecord](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_feature_store_DeleteRecord.html) API in the Amazon SageMaker API Reference guide.
    ttl_duration: ?TtlDuration = null,

    pub const json_field_names = .{
        .feature_group_name = "FeatureGroupName",
        .record = "Record",
        .target_stores = "TargetStores",
        .ttl_duration = "TtlDuration",
    };
};

const PutRecordOutput = struct {};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutRecordInput, options: Options) !PutRecordOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "sagemakerfeaturestoreruntime");

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutRecordInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemakerfeaturestoreruntime", "SageMaker FeatureStore Runtime", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/FeatureGroup/");
    try path_buf.appendSlice(allocator, input.feature_group_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Record\":");
    try aws.json.writeValue(@TypeOf(input.record), input.record, allocator, &body_buf);
    has_prev = true;
    if (input.target_stores) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TargetStores\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ttl_duration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TtlDuration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutRecordOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: PutRecordOutput = .{};

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

    if (std.mem.eql(u8, error_code, "AccessForbidden")) {
        return .{ .arena = arena, .kind = .{ .access_forbidden = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalFailure")) {
        return .{ .arena = arena, .kind = .{ .internal_failure = .{
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
    if (std.mem.eql(u8, error_code, "ServiceUnavailable")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationError")) {
        return .{ .arena = arena, .kind = .{ .validation_error = .{
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
