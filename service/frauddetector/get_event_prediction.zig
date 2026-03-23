const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Entity = @import("entity.zig").Entity;
const ModelEndpointDataBlob = @import("model_endpoint_data_blob.zig").ModelEndpointDataBlob;
const ExternalModelOutputs = @import("external_model_outputs.zig").ExternalModelOutputs;
const ModelScores = @import("model_scores.zig").ModelScores;
const RuleResult = @import("rule_result.zig").RuleResult;

pub const GetEventPredictionInput = struct {
    /// The detector ID.
    detector_id: []const u8,

    /// The detector version ID.
    detector_version_id: ?[]const u8 = null,

    /// The entity type (associated with the detector's event type) and specific
    /// entity ID representing who performed the event. If an entity id is not
    /// available, use "UNKNOWN."
    entities: []const Entity,

    /// The unique ID used to identify the event.
    event_id: []const u8,

    /// Timestamp that defines when the event under evaluation occurred. The
    /// timestamp must be specified using ISO 8601 standard in UTC.
    event_timestamp: []const u8,

    /// The event type associated with the detector specified for the prediction.
    event_type_name: []const u8,

    /// Names of the event type's variables you defined in Amazon Fraud Detector to
    /// represent data elements and
    /// their corresponding values for the event you are sending for evaluation.
    ///
    /// You must provide at least one eventVariable
    ///
    /// To ensure most accurate fraud prediction and to simplify your data
    /// preparation, Amazon Fraud Detector will replace all missing variables or
    /// values as follows:
    ///
    /// **For Amazon Fraud Detector trained models:**
    ///
    /// If a null value is provided explicitly for a variable or if a variable is
    /// missing, model will replace the null value or the missing variable (no
    /// variable name in the eventVariables map)
    /// with calculated default mean/medians for numeric variables and with special
    /// values for categorical variables.
    ///
    /// **For imported SageMaker models:**
    ///
    /// If a null value is provided explicitly for a variable, the model and rules
    /// will use “null” as the value. If a variable is not provided (no variable
    /// name in the eventVariables map), model and rules
    /// will use the default value that is provided for the variable.
    event_variables: []const aws.map.StringMapEntry,

    /// The Amazon SageMaker model endpoint input data blobs.
    external_model_endpoint_data_blobs: ?[]const aws.map.MapEntry(ModelEndpointDataBlob) = null,

    pub const json_field_names = .{
        .detector_id = "detectorId",
        .detector_version_id = "detectorVersionId",
        .entities = "entities",
        .event_id = "eventId",
        .event_timestamp = "eventTimestamp",
        .event_type_name = "eventTypeName",
        .event_variables = "eventVariables",
        .external_model_endpoint_data_blobs = "externalModelEndpointDataBlobs",
    };
};

pub const GetEventPredictionOutput = struct {
    /// The model scores for Amazon SageMaker models.
    external_model_outputs: ?[]const ExternalModelOutputs = null,

    /// The model scores. Amazon Fraud Detector generates model scores between 0 and
    /// 1000, where 0 is low fraud risk and 1000 is high fraud risk. Model scores
    /// are directly related to the false positive rate (FPR). For example, a score
    /// of 600 corresponds to an estimated 10% false positive rate whereas a score
    /// of 900 corresponds to an estimated 2% false positive rate.
    model_scores: ?[]const ModelScores = null,

    /// The results from the rules.
    rule_results: ?[]const RuleResult = null,

    pub const json_field_names = .{
        .external_model_outputs = "externalModelOutputs",
        .model_scores = "modelScores",
        .rule_results = "ruleResults",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEventPredictionInput, options: CallOptions) !GetEventPredictionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEventPredictionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSHawksNestServiceFacade.GetEventPrediction");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEventPredictionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetEventPredictionOutput, body, allocator);
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
