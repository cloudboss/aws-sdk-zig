const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SchemaAnalysisRuleRequest = @import("schema_analysis_rule_request.zig").SchemaAnalysisRuleRequest;
const AnalysisRule = @import("analysis_rule.zig").AnalysisRule;
const BatchGetSchemaAnalysisRuleError = @import("batch_get_schema_analysis_rule_error.zig").BatchGetSchemaAnalysisRuleError;

pub const BatchGetSchemaAnalysisRuleInput = struct {
    /// The unique identifier of the collaboration that contains the schema analysis
    /// rule.
    collaboration_identifier: []const u8,

    /// The information that's necessary to retrieve a schema analysis rule.
    schema_analysis_rule_requests: []const SchemaAnalysisRuleRequest,

    pub const json_field_names = .{
        .collaboration_identifier = "collaborationIdentifier",
        .schema_analysis_rule_requests = "schemaAnalysisRuleRequests",
    };
};

pub const BatchGetSchemaAnalysisRuleOutput = struct {
    /// The retrieved list of analysis rules.
    analysis_rules: ?[]const AnalysisRule = null,

    /// Error reasons for schemas that could not be retrieved. One error is returned
    /// for every schema that could not be retrieved.
    errors: ?[]const BatchGetSchemaAnalysisRuleError = null,

    pub const json_field_names = .{
        .analysis_rules = "analysisRules",
        .errors = "errors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetSchemaAnalysisRuleInput, options: CallOptions) !BatchGetSchemaAnalysisRuleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cleanrooms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetSchemaAnalysisRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms", "CleanRooms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/collaborations/");
    try path_buf.appendSlice(allocator, input.collaboration_identifier);
    try path_buf.appendSlice(allocator, "/batch-schema-analysis-rule");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"schemaAnalysisRuleRequests\":");
    try aws.json.writeValue(@TypeOf(input.schema_analysis_rule_requests), input.schema_analysis_rule_requests, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetSchemaAnalysisRuleOutput {
    var result: BatchGetSchemaAnalysisRuleOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchGetSchemaAnalysisRuleOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
