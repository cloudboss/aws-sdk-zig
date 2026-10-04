const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExportErrorReportLocation = @import("export_error_report_location.zig").ExportErrorReportLocation;
const ProcessingInput = @import("processing_input.zig").ProcessingInput;

pub const CreateDatasetExportJobInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request.
    /// The AWS SDKs and CLI populate this automatically.
    client_token: ?[]const u8 = null,

    /// The S3 URI where output clips will be written.
    destination_s3_uri: []const u8,

    /// The location where the error report will be written on failure.
    error_report_location: ExportErrorReportLocation,

    /// The processing input source.
    input: ProcessingInput,

    /// The name of the workspace in which to create the dataset export job.
    workspace_name: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .destination_s3_uri = "destinationS3Uri",
        .error_report_location = "errorReportLocation",
        .input = "input",
        .workspace_name = "workspaceName",
    };
};

pub const CreateDatasetExportJobOutput = struct {
    /// The unique identifier for the dataset export job.
    job_id: []const u8,

    /// The name of the workspace in which the dataset export job was created.
    workspace_name: []const u8,

    pub const json_field_names = .{
        .job_id = "jobId",
        .workspace_name = "workspaceName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDatasetExportJobInput, options: CallOptions) !CreateDatasetExportJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotsitewise", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDatasetExportJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_name);
    try path_buf.appendSlice(allocator, "/dataset-export-jobs");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"destinationS3Uri\":");
    try aws.json.writeValue(@TypeOf(input.destination_s3_uri), input.destination_s3_uri, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"errorReportLocation\":");
    try aws.json.writeValue(@TypeOf(input.error_report_location), input.error_report_location, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"input\":");
    try aws.json.writeValue(@TypeOf(input.input), input.input, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDatasetExportJobOutput {
    const result: CreateDatasetExportJobOutput = try aws.json.parseJsonObject(
        CreateDatasetExportJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
