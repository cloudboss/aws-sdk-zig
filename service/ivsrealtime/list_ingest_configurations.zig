const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IngestConfigurationState = @import("ingest_configuration_state.zig").IngestConfigurationState;
const IngestConfigurationSummary = @import("ingest_configuration_summary.zig").IngestConfigurationSummary;

pub const ListIngestConfigurationsInput = struct {
    /// Filters the response list to match the specified stage ARN. Only one filter
    /// (by stage ARN or by state) can be used at a time.
    filter_by_stage_arn: ?[]const u8 = null,

    /// Filters the response list to match the specified state. Only one filter (by
    /// stage ARN or by state) can be used at a time.
    filter_by_state: ?IngestConfigurationState = null,

    /// Maximum number of results to return. Default: 50.
    max_results: ?i32 = null,

    /// The first IngestConfiguration to retrieve. This is used for pagination; see
    /// the `nextToken` response field.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filter_by_stage_arn = "filterByStageArn",
        .filter_by_state = "filterByState",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListIngestConfigurationsOutput = struct {
    /// List of the matching ingest configurations (summary information only).
    ingest_configurations: ?[]const IngestConfigurationSummary = null,

    /// If there are more IngestConfigurations than `maxResults`, use `nextToken` in
    /// the request to get the next set.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .ingest_configurations = "ingestConfigurations",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListIngestConfigurationsInput, options: CallOptions) !ListIngestConfigurationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ivs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListIngestConfigurationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ivsrealtime", "IVS RealTime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ListIngestConfigurations";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filter_by_stage_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filterByStageArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.filter_by_state) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filterByState\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListIngestConfigurationsOutput {
    const result: ListIngestConfigurationsOutput = try aws.json.parseJsonObject(
        ListIngestConfigurationsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
