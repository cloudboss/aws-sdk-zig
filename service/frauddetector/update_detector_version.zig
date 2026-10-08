const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ModelVersion = @import("model_version.zig").ModelVersion;
const RuleExecutionMode = @import("rule_execution_mode.zig").RuleExecutionMode;
const Rule = @import("rule.zig").Rule;

pub const UpdateDetectorVersionInput = struct {
    /// The detector version description.
    description: ?[]const u8 = null,

    /// The parent detector ID for the detector version you want to update.
    detector_id: []const u8,

    /// The detector version ID.
    detector_version_id: []const u8,

    /// The Amazon SageMaker model endpoints to include in the detector version.
    external_model_endpoints: []const []const u8,

    /// The model versions to include in the detector version.
    model_versions: ?[]const ModelVersion = null,

    /// The rule execution mode to add to the detector.
    ///
    /// If you specify `FIRST_MATCHED`, Amazon Fraud Detector evaluates rules
    /// sequentially, first to last, stopping at the first matched rule. Amazon
    /// Fraud dectector then provides the outcomes for that single rule.
    ///
    /// If you specifiy `ALL_MATCHED`, Amazon Fraud Detector evaluates all rules and
    /// returns the outcomes for all matched rules. You can define and edit the rule
    /// mode at the detector version level, when it is in draft status.
    ///
    /// The default behavior is `FIRST_MATCHED`.
    rule_execution_mode: ?RuleExecutionMode = null,

    /// The rules to include in the detector version.
    rules: []const Rule,

    pub const json_field_names = .{
        .description = "description",
        .detector_id = "detectorId",
        .detector_version_id = "detectorVersionId",
        .external_model_endpoints = "externalModelEndpoints",
        .model_versions = "modelVersions",
        .rule_execution_mode = "ruleExecutionMode",
        .rules = "rules",
    };
};

pub const UpdateDetectorVersionOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDetectorVersionInput, options: CallOptions) !UpdateDetectorVersionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "frauddetector", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateDetectorVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("frauddetector", "FraudDetector", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSHawksNestServiceFacade.UpdateDetectorVersion");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateDetectorVersionOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
