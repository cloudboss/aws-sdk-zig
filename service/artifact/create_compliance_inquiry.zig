const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InquiryContent = @import("inquiry_content.zig").InquiryContent;
const InquirySupportMode = @import("inquiry_support_mode.zig").InquirySupportMode;
const InquirySummary = @import("inquiry_summary.zig").InquirySummary;

pub const CreateComplianceInquiryInput = struct {
    /// Idempotency token for the request.
    client_token: ?[]const u8 = null,

    /// Content for creating a compliance inquiry - either a single query or file
    /// content.
    inquiry_content: InquiryContent,

    /// Title of the inquiry.
    name: []const u8,

    /// Support mode for inquiry processing. Only supported for file upload mode.
    /// Defaults to AI_ONLY if not specified.
    support_mode: ?InquirySupportMode = null,

    /// Tags to associate with the compliance inquiry resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .inquiry_content = "inquiryContent",
        .name = "name",
        .support_mode = "supportMode",
        .tags = "tags",
    };
};

pub const CreateComplianceInquiryOutput = struct {
    /// Summary information about the created compliance inquiry.
    compliance_inquiry_summary: ?InquirySummary = null,

    /// Tags associated with the compliance inquiry resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .compliance_inquiry_summary = "complianceInquirySummary",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateComplianceInquiryInput, options: CallOptions) !CreateComplianceInquiryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateComplianceInquiryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("artifact", "Artifact", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/compliance-inquiry/create";

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
    try body_buf.appendSlice(allocator, "\"inquiryContent\":");
    try aws.json.writeValue(@TypeOf(input.inquiry_content), input.inquiry_content, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.support_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"supportMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateComplianceInquiryOutput {
    const result: CreateComplianceInquiryOutput = try aws.json.parseJsonObject(
        CreateComplianceInquiryOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
