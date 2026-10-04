const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IntermediateTableAnalysisRulePolicy = @import("intermediate_table_analysis_rule_policy.zig").IntermediateTableAnalysisRulePolicy;
const IntermediateTableAnalysisRuleType = @import("intermediate_table_analysis_rule_type.zig").IntermediateTableAnalysisRuleType;
const IntermediateTableAnalysisRule = @import("intermediate_table_analysis_rule.zig").IntermediateTableAnalysisRule;

pub const CreateIntermediateTableAnalysisRuleInput = struct {
    /// The analysis rule policy to apply to the intermediate table.
    analysis_rule_policy: IntermediateTableAnalysisRulePolicy,

    /// The type of analysis rule to create. Currently, only `CUSTOM` is supported.
    analysis_rule_type: IntermediateTableAnalysisRuleType,

    /// The unique identifier of the intermediate table for which to create the
    /// analysis rule.
    intermediate_table_identifier: []const u8,

    /// The unique identifier of the membership that contains the intermediate
    /// table.
    membership_identifier: []const u8,

    pub const json_field_names = .{
        .analysis_rule_policy = "analysisRulePolicy",
        .analysis_rule_type = "analysisRuleType",
        .intermediate_table_identifier = "intermediateTableIdentifier",
        .membership_identifier = "membershipIdentifier",
    };
};

pub const CreateIntermediateTableAnalysisRuleOutput = struct {
    /// The analysis rule that was created for the intermediate table.
    analysis_rule: ?IntermediateTableAnalysisRule = null,

    pub const json_field_names = .{
        .analysis_rule = "analysisRule",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateIntermediateTableAnalysisRuleInput, options: CallOptions) !CreateIntermediateTableAnalysisRuleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateIntermediateTableAnalysisRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms", "CleanRooms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/memberships/");
    try path_buf.appendSlice(allocator, input.membership_identifier);
    try path_buf.appendSlice(allocator, "/intermediateTables/");
    try path_buf.appendSlice(allocator, input.intermediate_table_identifier);
    try path_buf.appendSlice(allocator, "/analysisRule");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"analysisRulePolicy\":");
    try aws.json.writeValue(@TypeOf(input.analysis_rule_policy), input.analysis_rule_policy, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"analysisRuleType\":");
    try aws.json.writeValue(@TypeOf(input.analysis_rule_type), input.analysis_rule_type, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateIntermediateTableAnalysisRuleOutput {
    const result: CreateIntermediateTableAnalysisRuleOutput = try aws.json.parseJsonObject(
        CreateIntermediateTableAnalysisRuleOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
