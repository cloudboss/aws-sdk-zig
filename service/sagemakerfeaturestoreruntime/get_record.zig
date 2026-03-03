const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ExpirationTimeResponse = @import("expiration_time_response.zig").ExpirationTimeResponse;
const FeatureValue = @import("feature_value.zig").FeatureValue;

pub const GetRecordInput = struct {
    /// Parameter to request `ExpiresAt` in response. If `Enabled`,
    /// `GetRecord` will return the value of `ExpiresAt`, if it is not
    /// null. If `Disabled` and null, `GetRecord` will return null.
    expiration_time_response: ?ExpirationTimeResponse = null,

    /// The name or Amazon Resource Name (ARN) of the feature group from which you
    /// want to
    /// retrieve a record.
    feature_group_name: []const u8,

    /// List of names of Features to be retrieved. If not specified, the latest
    /// value for all
    /// the Features are returned.
    feature_names: ?[]const []const u8 = null,

    /// The value that corresponds to `RecordIdentifier` type and uniquely
    /// identifies
    /// the record in the `FeatureGroup`.
    record_identifier_value_as_string: []const u8,

    pub const json_field_names = .{
        .expiration_time_response = "ExpirationTimeResponse",
        .feature_group_name = "FeatureGroupName",
        .feature_names = "FeatureNames",
        .record_identifier_value_as_string = "RecordIdentifierValueAsString",
    };
};

pub const GetRecordOutput = struct {
    /// The `ExpiresAt` ISO string of the requested record.
    expires_at: ?[]const u8 = null,

    /// The record you requested. A list of `FeatureValues`.
    record: ?[]const FeatureValue = null,

    pub const json_field_names = .{
        .expires_at = "ExpiresAt",
        .record = "Record",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRecordInput, options: CallOptions) !GetRecordOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRecordInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemakerfeaturestoreruntime", "SageMaker FeatureStore Runtime", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/FeatureGroup/");
    try path_buf.appendSlice(allocator, input.feature_group_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.expiration_time_response) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "ExpirationTimeResponse=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.feature_names) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "FeatureName=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "RecordIdentifierValueAsString=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.record_identifier_value_as_string);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRecordOutput {
    var result: GetRecordOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetRecordOutput, body, allocator);
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
