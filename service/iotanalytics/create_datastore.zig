const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DatastorePartitions = @import("datastore_partitions.zig").DatastorePartitions;
const DatastoreStorage = @import("datastore_storage.zig").DatastoreStorage;
const FileFormatConfiguration = @import("file_format_configuration.zig").FileFormatConfiguration;
const RetentionPeriod = @import("retention_period.zig").RetentionPeriod;
const Tag = @import("tag.zig").Tag;

pub const CreateDatastoreInput = struct {
    /// The name of the data store.
    datastore_name: []const u8,

    /// Contains information about the partition dimensions in a data store.
    datastore_partitions: ?DatastorePartitions = null,

    /// Where data in a data store is stored.. You can choose `serviceManagedS3`
    /// storage, `customerManagedS3` storage, or `iotSiteWiseMultiLayerStorage`
    /// storage. The default is `serviceManagedS3`. You can't change the choice of
    /// Amazon S3 storage after your data store is created.
    datastore_storage: ?DatastoreStorage = null,

    /// Contains the configuration information of file formats. IoT Analytics data
    /// stores support JSON and [Parquet](https://parquet.apache.org/).
    ///
    /// The default file format is JSON. You can specify only one format.
    ///
    /// You can't change the file format after you create the data store.
    file_format_configuration: ?FileFormatConfiguration = null,

    /// How long, in days, message data is kept for the data store. When
    /// `customerManagedS3` storage is selected, this parameter is ignored.
    retention_period: ?RetentionPeriod = null,

    /// Metadata which can be used to manage the data store.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .datastore_name = "datastoreName",
        .datastore_partitions = "datastorePartitions",
        .datastore_storage = "datastoreStorage",
        .file_format_configuration = "fileFormatConfiguration",
        .retention_period = "retentionPeriod",
        .tags = "tags",
    };
};

pub const CreateDatastoreOutput = struct {
    /// The ARN of the data store.
    datastore_arn: ?[]const u8 = null,

    /// The name of the data store.
    datastore_name: ?[]const u8 = null,

    /// How long, in days, message data is kept for the data store.
    retention_period: ?RetentionPeriod = null,

    pub const json_field_names = .{
        .datastore_arn = "datastoreArn",
        .datastore_name = "datastoreName",
        .retention_period = "retentionPeriod",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDatastoreInput, options: Options) !CreateDatastoreOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "iotanalytics");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDatastoreInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotanalytics", "IoTAnalytics", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/datastores";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"datastoreName\":");
    try aws.json.writeValue(@TypeOf(input.datastore_name), input.datastore_name, allocator, &body_buf);
    has_prev = true;
    if (input.datastore_partitions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"datastorePartitions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.datastore_storage) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"datastoreStorage\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.file_format_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"fileFormatConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.retention_period) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"retentionPeriod\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDatastoreOutput {
    var result: CreateDatastoreOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateDatastoreOutput, body, allocator);
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
