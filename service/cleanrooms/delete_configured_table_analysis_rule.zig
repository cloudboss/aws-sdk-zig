const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConfiguredTableAnalysisRuleType = @import("configured_table_analysis_rule_type.zig").ConfiguredTableAnalysisRuleType;

pub const DeleteConfiguredTableAnalysisRuleInput = struct {
    /// The analysis rule type to be deleted. Configured table analysis rules are
    /// uniquely identified by their configured table identifier and analysis rule
    /// type.
    analysis_rule_type: ConfiguredTableAnalysisRuleType,

    /// The unique identifier for the configured table that the analysis rule
    /// applies to. Currently accepts the configured table ID.
    configured_table_identifier: []const u8,

    pub const json_field_names = .{
        .analysis_rule_type = "analysisRuleType",
        .configured_table_identifier = "configuredTableIdentifier",
    };
};

pub const DeleteConfiguredTableAnalysisRuleOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteConfiguredTableAnalysisRuleInput, options: CallOptions) !DeleteConfiguredTableAnalysisRuleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteConfiguredTableAnalysisRuleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms", "CleanRooms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/configuredTables/");
    try path_buf.appendSlice(allocator, input.configured_table_identifier);
    try path_buf.appendSlice(allocator, "/analysisRule/");
    try path_buf.appendSlice(allocator, input.analysis_rule_type);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteConfiguredTableAnalysisRuleOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DeleteConfiguredTableAnalysisRuleOutput = .{};

    return result;
}
