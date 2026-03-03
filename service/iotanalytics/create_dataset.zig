const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DatasetAction = @import("dataset_action.zig").DatasetAction;
const DatasetContentDeliveryRule = @import("dataset_content_delivery_rule.zig").DatasetContentDeliveryRule;
const LateDataRule = @import("late_data_rule.zig").LateDataRule;
const RetentionPeriod = @import("retention_period.zig").RetentionPeriod;
const Tag = @import("tag.zig").Tag;
const DatasetTrigger = @import("dataset_trigger.zig").DatasetTrigger;
const VersioningConfiguration = @import("versioning_configuration.zig").VersioningConfiguration;

pub const CreateDatasetInput = struct {
    /// A list of actions that create the dataset contents.
    actions: []const DatasetAction,

    /// When dataset contents are created, they are delivered to destinations
    /// specified
    /// here.
    content_delivery_rules: ?[]const DatasetContentDeliveryRule = null,

    /// The name of the dataset.
    dataset_name: []const u8,

    /// A list of data rules that send notifications to CloudWatch, when data
    /// arrives late. To specify `lateDataRules`, the dataset must use a
    /// [DeltaTimer](https://docs.aws.amazon.com/iotanalytics/latest/APIReference/API_DeltaTime.html) filter.
    late_data_rules: ?[]const LateDataRule = null,

    /// Optional. How long, in days, versions of dataset contents are kept for the
    /// dataset. If not
    /// specified or set to `null`, versions of dataset contents are retained for at
    /// most
    /// 90 days. The number of versions of dataset contents retained is determined
    /// by the
    /// `versioningConfiguration` parameter. For more information, see [
    /// Keeping Multiple Versions of IoT Analytics
    /// datasets](https://docs.aws.amazon.com/iotanalytics/latest/userguide/getting-started.html#aws-iot-analytics-dataset-versions) in the
    /// *IoT Analytics User Guide*.
    retention_period: ?RetentionPeriod = null,

    /// Metadata which can be used to manage the dataset.
    tags: ?[]const Tag = null,

    /// A list of triggers. A trigger causes dataset contents to be populated at a
    /// specified time
    /// interval or when another dataset's contents are created. The list of
    /// triggers can be empty or
    /// contain up to five `DataSetTrigger` objects.
    triggers: ?[]const DatasetTrigger = null,

    /// Optional. How many versions of dataset contents are kept. If not specified
    /// or set to null,
    /// only the latest version plus the latest succeeded version (if they are
    /// different) are kept for
    /// the time period specified by the `retentionPeriod` parameter. For more
    /// information,
    /// see [Keeping Multiple Versions of IoT Analytics
    /// datasets](https://docs.aws.amazon.com/iotanalytics/latest/userguide/getting-started.html#aws-iot-analytics-dataset-versions) in the
    /// *IoT Analytics User Guide*.
    versioning_configuration: ?VersioningConfiguration = null,

    pub const json_field_names = .{
        .actions = "actions",
        .content_delivery_rules = "contentDeliveryRules",
        .dataset_name = "datasetName",
        .late_data_rules = "lateDataRules",
        .retention_period = "retentionPeriod",
        .tags = "tags",
        .triggers = "triggers",
        .versioning_configuration = "versioningConfiguration",
    };
};

pub const CreateDatasetOutput = struct {
    /// The ARN of the dataset.
    dataset_arn: ?[]const u8 = null,

    /// The name of the dataset.
    dataset_name: ?[]const u8 = null,

    /// How long, in days, dataset contents are kept for the dataset.
    retention_period: ?RetentionPeriod = null,

    pub const json_field_names = .{
        .dataset_arn = "datasetArn",
        .dataset_name = "datasetName",
        .retention_period = "retentionPeriod",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDatasetInput, options: Options) !CreateDatasetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDatasetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotanalytics", "IoTAnalytics", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/datasets";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"actions\":");
    try aws.json.writeValue(@TypeOf(input.actions), input.actions, allocator, &body_buf);
    has_prev = true;
    if (input.content_delivery_rules) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"contentDeliveryRules\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"datasetName\":");
    try aws.json.writeValue(@TypeOf(input.dataset_name), input.dataset_name, allocator, &body_buf);
    has_prev = true;
    if (input.late_data_rules) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"lateDataRules\":");
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
    if (input.triggers) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"triggers\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.versioning_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"versioningConfiguration\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDatasetOutput {
    var result: CreateDatasetOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateDatasetOutput, body, allocator);
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
