const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IntermediateTableComputeConfiguration = @import("intermediate_table_compute_configuration.zig").IntermediateTableComputeConfiguration;
const PopulateIntermediateTableAnalysisType = @import("populate_intermediate_table_analysis_type.zig").PopulateIntermediateTableAnalysisType;

pub const PopulateIntermediateTableInput = struct {
    /// The account ID of the member that pays for the analysis compute costs.
    analysis_payer_account_id: ?[]const u8 = null,

    /// The compute configuration for the population query execution.
    compute_configuration: ?IntermediateTableComputeConfiguration = null,

    /// The unique identifier of the intermediate table to populate.
    intermediate_table_identifier: []const u8,

    /// The unique identifier of the membership that contains the intermediate
    /// table.
    membership_identifier: []const u8,

    /// The runtime parameter values that override the defaults in the stored query.
    parameters: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .analysis_payer_account_id = "analysisPayerAccountId",
        .compute_configuration = "computeConfiguration",
        .intermediate_table_identifier = "intermediateTableIdentifier",
        .membership_identifier = "membershipIdentifier",
        .parameters = "parameters",
    };
};

pub const PopulateIntermediateTableOutput = struct {
    /// The identifier for the protected query execution that populated the
    /// intermediate table.
    analysis_id: []const u8,

    /// The type of analysis performed to populate the intermediate table.
    analysis_type: PopulateIntermediateTableAnalysisType,

    /// The unique identifier of the version created by this population operation.
    version_id: []const u8,

    pub const json_field_names = .{
        .analysis_id = "analysisId",
        .analysis_type = "analysisType",
        .version_id = "versionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PopulateIntermediateTableInput, options: CallOptions) !PopulateIntermediateTableOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PopulateIntermediateTableInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms", "CleanRooms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/memberships/");
    try path_buf.appendSlice(allocator, input.membership_identifier);
    try path_buf.appendSlice(allocator, "/intermediateTables/");
    try path_buf.appendSlice(allocator, input.intermediate_table_identifier);
    try path_buf.appendSlice(allocator, "/populate");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.analysis_payer_account_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"analysisPayerAccountId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.compute_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"computeConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"parameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PopulateIntermediateTableOutput {
    const result: PopulateIntermediateTableOutput = try aws.json.parseJsonObject(
        PopulateIntermediateTableOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
