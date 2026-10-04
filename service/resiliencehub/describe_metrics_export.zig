const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const S3Location = @import("s3_location.zig").S3Location;
const MetricsExportStatusType = @import("metrics_export_status_type.zig").MetricsExportStatusType;

pub const DescribeMetricsExportInput = struct {
    /// Identifier of the metrics export task.
    metrics_export_id: []const u8,

    pub const json_field_names = .{
        .metrics_export_id = "metricsExportId",
    };
};

pub const DescribeMetricsExportOutput = struct {
    /// Explains the error that occurred while exporting the metrics.
    error_message: ?[]const u8 = null,

    /// Specifies the name of the Amazon S3 bucket where the exported metrics is
    /// stored.
    export_location: ?S3Location = null,

    /// Identifier for the metrics export task.
    metrics_export_id: []const u8,

    /// Indicates the status of the metrics export task.
    status: MetricsExportStatusType,

    pub const json_field_names = .{
        .error_message = "errorMessage",
        .export_location = "exportLocation",
        .metrics_export_id = "metricsExportId",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeMetricsExportInput, options: CallOptions) !DescribeMetricsExportOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "resiliencehub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeMetricsExportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resiliencehub", "resiliencehub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/describe-metrics-export";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"metricsExportId\":");
    try aws.json.writeValue(@TypeOf(input.metrics_export_id), input.metrics_export_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeMetricsExportOutput {
    const result: DescribeMetricsExportOutput = try aws.json.parseJsonObject(
        DescribeMetricsExportOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
