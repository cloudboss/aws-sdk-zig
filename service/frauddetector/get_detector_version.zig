const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ModelVersion = @import("model_version.zig").ModelVersion;
const RuleExecutionMode = @import("rule_execution_mode.zig").RuleExecutionMode;
const Rule = @import("rule.zig").Rule;
const DetectorVersionStatus = @import("detector_version_status.zig").DetectorVersionStatus;

pub const GetDetectorVersionInput = struct {
    /// The detector ID.
    detector_id: []const u8,

    /// The detector version ID.
    detector_version_id: []const u8,

    pub const json_field_names = .{
        .detector_id = "detectorId",
        .detector_version_id = "detectorVersionId",
    };
};

pub const GetDetectorVersionOutput = struct {
    /// The detector version ARN.
    arn: ?[]const u8 = null,

    /// The timestamp when the detector version was created.
    created_time: ?[]const u8 = null,

    /// The detector version description.
    description: ?[]const u8 = null,

    /// The detector ID.
    detector_id: ?[]const u8 = null,

    /// The detector version ID.
    detector_version_id: ?[]const u8 = null,

    /// The Amazon SageMaker model endpoints included in the detector version.
    external_model_endpoints: ?[]const []const u8 = null,

    /// The timestamp when the detector version was last updated.
    last_updated_time: ?[]const u8 = null,

    /// The model versions included in the detector version.
    model_versions: ?[]const ModelVersion = null,

    /// The execution mode of the rule in the dectector
    ///
    /// `FIRST_MATCHED` indicates that Amazon Fraud Detector evaluates rules
    /// sequentially, first to last, stopping at the first matched rule. Amazon
    /// Fraud dectector then provides the outcomes for that single rule.
    ///
    /// `ALL_MATCHED` indicates that Amazon Fraud Detector evaluates all rules and
    /// returns the outcomes for all matched rules. You can define and edit the rule
    /// mode at the detector version level, when it is in draft status.
    rule_execution_mode: ?RuleExecutionMode = null,

    /// The rules included in the detector version.
    rules: ?[]const Rule = null,

    /// The status of the detector version.
    status: ?DetectorVersionStatus = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_time = "createdTime",
        .description = "description",
        .detector_id = "detectorId",
        .detector_version_id = "detectorVersionId",
        .external_model_endpoints = "externalModelEndpoints",
        .last_updated_time = "lastUpdatedTime",
        .model_versions = "modelVersions",
        .rule_execution_mode = "ruleExecutionMode",
        .rules = "rules",
        .status = "status",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDetectorVersionInput, options: Options) !GetDetectorVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "frauddetector");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetDetectorVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("frauddetector", "FraudDetector", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "AWSHawksNestServiceFacade.GetDetectorVersion");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetDetectorVersionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetDetectorVersionOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .resource_unavailable_exception = .{
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
