const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ExportComplianceInquiryInput = struct {
    /// Unique resource ID for the compliance inquiry.
    compliance_inquiry_id: []const u8,

    /// When true, include citations in the exported document.
    include_citations: ?bool = null,

    /// List of query identifiers to include in the export.
    query_identifiers: ?[]const i32 = null,

    pub const json_field_names = .{
        .compliance_inquiry_id = "complianceInquiryId",
        .include_citations = "includeCitations",
        .query_identifiers = "queryIdentifiers",
    };
};

pub const ExportComplianceInquiryOutput = struct {
    /// Presigned S3 URL to access the exported compliance inquiry report.
    document_presigned_url: ?[]const u8 = null,

    /// Tags associated with the compliance inquiry resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .document_presigned_url = "documentPresignedUrl",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ExportComplianceInquiryInput, options: CallOptions) !ExportComplianceInquiryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "artifact", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ExportComplianceInquiryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("artifact", "Artifact", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/compliance-inquiry/export";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"complianceInquiryId\":");
    try aws.json.writeValue(@TypeOf(input.compliance_inquiry_id), input.compliance_inquiry_id, allocator, &body_buf);
    has_prev = true;
    if (input.include_citations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"includeCitations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.query_identifiers) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"queryIdentifiers\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ExportComplianceInquiryOutput {
    const result: ExportComplianceInquiryOutput = try aws.json.parseJsonObject(
        ExportComplianceInquiryOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
