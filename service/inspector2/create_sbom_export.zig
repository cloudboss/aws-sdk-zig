const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SbomReportFormat = @import("sbom_report_format.zig").SbomReportFormat;
const ResourceFilterCriteria = @import("resource_filter_criteria.zig").ResourceFilterCriteria;
const Destination = @import("destination.zig").Destination;

pub const CreateSbomExportInput = struct {
    /// The output format for the software bill of materials (SBOM) report.
    report_format: SbomReportFormat,

    /// The resource filter criteria for the software bill of materials (SBOM)
    /// report.
    resource_filter_criteria: ?ResourceFilterCriteria = null,

    /// Contains details of the Amazon S3 bucket and KMS key used to export
    /// findings.
    s_3_destination: Destination,

    pub const json_field_names = .{
        .report_format = "reportFormat",
        .resource_filter_criteria = "resourceFilterCriteria",
        .s_3_destination = "s3Destination",
    };
};

pub const CreateSbomExportOutput = struct {
    /// The report ID for the software bill of materials (SBOM) report.
    report_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .report_id = "reportId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSbomExportInput, options: CallOptions) !CreateSbomExportOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "inspector2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSbomExportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("inspector2", "Inspector2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/sbomexport/create";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"reportFormat\":");
    try aws.json.writeValue(@TypeOf(input.report_format), input.report_format, allocator, &body_buf);
    has_prev = true;
    if (input.resource_filter_criteria) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"resourceFilterCriteria\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"s3Destination\":");
    try aws.json.writeValue(@TypeOf(input.s_3_destination), input.s_3_destination, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSbomExportOutput {
    var result: CreateSbomExportOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateSbomExportOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
