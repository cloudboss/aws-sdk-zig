const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const EvaluatedExternalModel = @import("evaluated_external_model.zig").EvaluatedExternalModel;
const EvaluatedModelVersion = @import("evaluated_model_version.zig").EvaluatedModelVersion;
const EventVariableSummary = @import("event_variable_summary.zig").EventVariableSummary;
const RuleExecutionMode = @import("rule_execution_mode.zig").RuleExecutionMode;
const EvaluatedRule = @import("evaluated_rule.zig").EvaluatedRule;

pub const GetEventPredictionMetadataInput = struct {
    /// The detector ID.
    detector_id: []const u8,

    /// The detector version ID.
    detector_version_id: []const u8,

    /// The event ID.
    event_id: []const u8,

    /// The event type associated with the detector specified for the prediction.
    event_type_name: []const u8,

    /// The timestamp that defines when the prediction was generated. The timestamp
    /// must be specified using ISO 8601 standard in UTC.
    ///
    /// We recommend calling
    /// [ListEventPredictions](https://docs.aws.amazon.com/frauddetector/latest/api/API_ListEventPredictions.html)
    /// first, and using the `predictionTimestamp` value in the response to provide
    /// an accurate prediction timestamp value.
    prediction_timestamp: []const u8,

    pub const json_field_names = .{
        .detector_id = "detectorId",
        .detector_version_id = "detectorVersionId",
        .event_id = "eventId",
        .event_type_name = "eventTypeName",
        .prediction_timestamp = "predictionTimestamp",
    };
};

pub const GetEventPredictionMetadataOutput = struct {
    /// The detector ID.
    detector_id: ?[]const u8 = null,

    /// The detector version ID.
    detector_version_id: ?[]const u8 = null,

    /// The status of the detector version.
    detector_version_status: ?[]const u8 = null,

    /// The entity ID.
    entity_id: ?[]const u8 = null,

    /// The entity type.
    entity_type: ?[]const u8 = null,

    /// External (Amazon SageMaker) models that were evaluated for generating
    /// predictions.
    evaluated_external_models: ?[]const EvaluatedExternalModel = null,

    /// Model versions that were evaluated for generating predictions.
    evaluated_model_versions: ?[]const EvaluatedModelVersion = null,

    /// The event ID.
    event_id: ?[]const u8 = null,

    /// The timestamp for when the prediction was generated for the associated event
    /// ID.
    event_timestamp: ?[]const u8 = null,

    /// The event type associated with the detector specified for this prediction.
    event_type_name: ?[]const u8 = null,

    /// A list of event variables that influenced the prediction scores.
    event_variables: ?[]const EventVariableSummary = null,

    /// The outcomes of the matched rule, based on the rule execution mode.
    outcomes: ?[]const []const u8 = null,

    /// The timestamp that defines when the prediction was generated.
    prediction_timestamp: ?[]const u8 = null,

    /// The execution mode of the rule used for evaluating variable values.
    rule_execution_mode: ?RuleExecutionMode = null,

    /// List of rules associated with the detector version that were used for
    /// evaluating variable values.
    rules: ?[]const EvaluatedRule = null,

    pub const json_field_names = .{
        .detector_id = "detectorId",
        .detector_version_id = "detectorVersionId",
        .detector_version_status = "detectorVersionStatus",
        .entity_id = "entityId",
        .entity_type = "entityType",
        .evaluated_external_models = "evaluatedExternalModels",
        .evaluated_model_versions = "evaluatedModelVersions",
        .event_id = "eventId",
        .event_timestamp = "eventTimestamp",
        .event_type_name = "eventTypeName",
        .event_variables = "eventVariables",
        .outcomes = "outcomes",
        .prediction_timestamp = "predictionTimestamp",
        .rule_execution_mode = "ruleExecutionMode",
        .rules = "rules",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEventPredictionMetadataInput, options: Options) !GetEventPredictionMetadataOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetEventPredictionMetadataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("frauddetector", "FraudDetector", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "AWSHawksNestServiceFacade.GetEventPredictionMetadata");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEventPredictionMetadataOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetEventPredictionMetadataOutput, body, allocator);
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
