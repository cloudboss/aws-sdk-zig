const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Group = @import("group.zig").Group;
const OutputFormat = @import("output_format.zig").OutputFormat;

pub const StartRecommendationReportGenerationInput = struct {
    /// Groups the resources in the recommendation report with a unique name.
    group_id_filter: ?[]const Group = null,

    /// The output format for the recommendation report file. The default format is
    /// Microsoft
    /// Excel.
    output_format: ?OutputFormat = null,

    pub const json_field_names = .{
        .group_id_filter = "groupIdFilter",
        .output_format = "outputFormat",
    };
};

pub const StartRecommendationReportGenerationOutput = struct {
    /// The ID of the recommendation report generation task.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "id",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartRecommendationReportGenerationInput, options: CallOptions) !StartRecommendationReportGenerationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsmigrationhubstrategyrecommendation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartRecommendationReportGenerationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("migrationhub-strategy", "MigrationHubStrategy", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/start-recommendation-report-generation";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.group_id_filter) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"groupIdFilter\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.output_format) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"outputFormat\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartRecommendationReportGenerationOutput {
    var result: StartRecommendationReportGenerationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartRecommendationReportGenerationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
