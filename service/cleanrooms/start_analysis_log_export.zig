const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LogExportAnalysisType = @import("log_export_analysis_type.zig").LogExportAnalysisType;
const AnalysisLogExportResultConfiguration = @import("analysis_log_export_result_configuration.zig").AnalysisLogExportResultConfiguration;
const AnalysisLogExport = @import("analysis_log_export.zig").AnalysisLogExport;

pub const StartAnalysisLogExportInput = struct {
    /// The unique identifier of the protected query that you want to export the
    /// analysis logs for.
    analysis_id: []const u8,

    /// The type of analysis that the logs are exported for. Currently, only
    /// `PROTECTED_QUERY` is supported.
    analysis_type: LogExportAnalysisType,

    /// A unique identifier for the membership to export the analysis logs for.
    /// Currently accepts a membership ID.
    membership_identifier: []const u8,

    /// The details needed to write the exported analysis logs.
    ///
    /// You don't need to create an IAM role for log export. Clean Rooms writes the
    /// exported logs using your own identity, so Clean Rooms writes the exported
    /// logs only where your existing permissions allow.
    result_configuration: AnalysisLogExportResultConfiguration,

    pub const json_field_names = .{
        .analysis_id = "analysisId",
        .analysis_type = "analysisType",
        .membership_identifier = "membershipIdentifier",
        .result_configuration = "resultConfiguration",
    };
};

pub const StartAnalysisLogExportOutput = struct {
    /// The analysis log export that was started. The `status` is `IN_PROGRESS`.
    analysis_log_export: ?AnalysisLogExport = null,

    pub const json_field_names = .{
        .analysis_log_export = "analysisLogExport",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartAnalysisLogExportInput, options: CallOptions) !StartAnalysisLogExportOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartAnalysisLogExportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms", "CleanRooms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/memberships/");
    try path_buf.appendSlice(allocator, input.membership_identifier);
    try path_buf.appendSlice(allocator, "/analysislogexports");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"analysisId\":");
    try aws.json.writeValue(@TypeOf(input.analysis_id), input.analysis_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"analysisType\":");
    try aws.json.writeValue(@TypeOf(input.analysis_type), input.analysis_type, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resultConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.result_configuration), input.result_configuration, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartAnalysisLogExportOutput {
    const result: StartAnalysisLogExportOutput = try aws.json.parseJsonObject(
        StartAnalysisLogExportOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
