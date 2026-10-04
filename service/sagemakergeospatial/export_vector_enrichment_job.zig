const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExportVectorEnrichmentJobOutputConfig = @import("export_vector_enrichment_job_output_config.zig").ExportVectorEnrichmentJobOutputConfig;
const VectorEnrichmentJobExportStatus = @import("vector_enrichment_job_export_status.zig").VectorEnrichmentJobExportStatus;

pub const ExportVectorEnrichmentJobInput = struct {
    /// The Amazon Resource Name (ARN) of the Vector Enrichment job.
    arn: []const u8,

    /// A unique token that guarantees that the call to this API is idempotent.
    client_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM rolewith permission to upload to
    /// the location in OutputConfig.
    execution_role_arn: []const u8,

    /// Output location information for exporting Vector Enrichment Job results.
    output_config: ExportVectorEnrichmentJobOutputConfig,

    pub const json_field_names = .{
        .arn = "Arn",
        .client_token = "ClientToken",
        .execution_role_arn = "ExecutionRoleArn",
        .output_config = "OutputConfig",
    };
};

pub const ExportVectorEnrichmentJobOutput = struct {
    /// The Amazon Resource Name (ARN) of the Vector Enrichment job being exported.
    arn: []const u8,

    /// The creation time.
    creation_time: i64,

    /// The Amazon Resource Name (ARN) of the IAM role with permission to upload to
    /// the location in OutputConfig.
    execution_role_arn: []const u8,

    /// The status of the results the Vector Enrichment job being exported.
    export_status: VectorEnrichmentJobExportStatus,

    /// Output location information for exporting Vector Enrichment Job results.
    output_config: ?ExportVectorEnrichmentJobOutputConfig = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .execution_role_arn = "ExecutionRoleArn",
        .export_status = "ExportStatus",
        .output_config = "OutputConfig",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ExportVectorEnrichmentJobInput, options: CallOptions) !ExportVectorEnrichmentJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker-geospatial", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ExportVectorEnrichmentJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("sagemaker-geospatial", "SageMaker Geospatial", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/export-vector-enrichment-jobs";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Arn\":");
    try aws.json.writeValue(@TypeOf(input.arn), input.arn, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ExecutionRoleArn\":");
    try aws.json.writeValue(@TypeOf(input.execution_role_arn), input.execution_role_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"OutputConfig\":");
    try aws.json.writeValue(@TypeOf(input.output_config), input.output_config, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ExportVectorEnrichmentJobOutput {
    const result: ExportVectorEnrichmentJobOutput = try aws.json.parseJsonObject(
        ExportVectorEnrichmentJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
