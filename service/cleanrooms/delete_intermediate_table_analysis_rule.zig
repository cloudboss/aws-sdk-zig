const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IntermediateTableAnalysisRuleType = @import("intermediate_table_analysis_rule_type.zig").IntermediateTableAnalysisRuleType;

pub const DeleteIntermediateTableAnalysisRuleInput = struct {
    /// The type of analysis rule to delete. Currently, only `CUSTOM` is supported.
    analysis_rule_type: IntermediateTableAnalysisRuleType,

    /// The unique identifier of the intermediate table from which to delete the
    /// analysis rule.
    intermediate_table_identifier: []const u8,

    /// The unique identifier of the membership that contains the intermediate
    /// table.
    membership_identifier: []const u8,

    pub const json_field_names = .{
        .analysis_rule_type = "analysisRuleType",
        .intermediate_table_identifier = "intermediateTableIdentifier",
        .membership_identifier = "membershipIdentifier",
    };
};

pub const DeleteIntermediateTableAnalysisRuleOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteIntermediateTableAnalysisRuleInput, options: CallOptions) !DeleteIntermediateTableAnalysisRuleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteIntermediateTableAnalysisRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms", "CleanRooms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/memberships/");
    try path_buf.appendSlice(allocator, input.membership_identifier);
    try path_buf.appendSlice(allocator, "/intermediateTables/");
    try path_buf.appendSlice(allocator, input.intermediate_table_identifier);
    try path_buf.appendSlice(allocator, "/analysisRule/");
    try path_buf.appendSlice(allocator, input.analysis_rule_type.wireName());
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteIntermediateTableAnalysisRuleOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DeleteIntermediateTableAnalysisRuleOutput = .{};

    return result;
}
