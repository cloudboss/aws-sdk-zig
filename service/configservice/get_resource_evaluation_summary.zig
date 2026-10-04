const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ComplianceType = @import("compliance_type.zig").ComplianceType;
const EvaluationContext = @import("evaluation_context.zig").EvaluationContext;
const EvaluationMode = @import("evaluation_mode.zig").EvaluationMode;
const EvaluationStatus = @import("evaluation_status.zig").EvaluationStatus;
const ResourceDetails = @import("resource_details.zig").ResourceDetails;

pub const GetResourceEvaluationSummaryInput = struct {
    /// The unique `ResourceEvaluationId` of Amazon Web Services resource execution
    /// for which you want to retrieve the evaluation summary.
    resource_evaluation_id: []const u8,

    pub const json_field_names = .{
        .resource_evaluation_id = "ResourceEvaluationId",
    };
};

pub const GetResourceEvaluationSummaryOutput = struct {
    /// The compliance status of the resource evaluation summary.
    compliance: ?ComplianceType = null,

    /// Returns an `EvaluationContext` object.
    evaluation_context: ?EvaluationContext = null,

    /// Lists results of the mode that you requested to retrieve the resource
    /// evaluation summary. The valid values are Detective or Proactive.
    evaluation_mode: ?EvaluationMode = null,

    /// The start timestamp when Config rule starts evaluating compliance for the
    /// provided resource details.
    evaluation_start_timestamp: ?i64 = null,

    /// Returns an `EvaluationStatus` object.
    evaluation_status: ?EvaluationStatus = null,

    /// Returns a `ResourceDetails` object.
    resource_details: ?ResourceDetails = null,

    /// The unique `ResourceEvaluationId` of Amazon Web Services resource execution
    /// for which you want to retrieve the evaluation summary.
    resource_evaluation_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .compliance = "Compliance",
        .evaluation_context = "EvaluationContext",
        .evaluation_mode = "EvaluationMode",
        .evaluation_start_timestamp = "EvaluationStartTimestamp",
        .evaluation_status = "EvaluationStatus",
        .resource_details = "ResourceDetails",
        .resource_evaluation_id = "ResourceEvaluationId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetResourceEvaluationSummaryInput, options: CallOptions) !GetResourceEvaluationSummaryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "config", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetResourceEvaluationSummaryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("config", "Config Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "StarlingDoveService.GetResourceEvaluationSummary");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetResourceEvaluationSummaryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetResourceEvaluationSummaryOutput, body, allocator);
}
