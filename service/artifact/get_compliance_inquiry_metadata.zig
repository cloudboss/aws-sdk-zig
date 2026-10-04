const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InquiryDetail = @import("inquiry_detail.zig").InquiryDetail;

pub const GetComplianceInquiryMetadataInput = struct {
    /// Unique resource ID for the compliance inquiry.
    compliance_inquiry_id: []const u8,

    pub const json_field_names = .{
        .compliance_inquiry_id = "complianceInquiryId",
    };
};

pub const GetComplianceInquiryMetadataOutput = struct {
    /// Detailed information about the compliance inquiry.
    compliance_inquiry_detail: ?InquiryDetail = null,

    /// Tags associated with the compliance inquiry resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .compliance_inquiry_detail = "complianceInquiryDetail",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetComplianceInquiryMetadataInput, options: CallOptions) !GetComplianceInquiryMetadataOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetComplianceInquiryMetadataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("artifact", "Artifact", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/compliance-inquiry/getMetadata";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "complianceInquiryId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.compliance_inquiry_id);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetComplianceInquiryMetadataOutput {
    const result: GetComplianceInquiryMetadataOutput = try aws.json.parseJsonObject(
        GetComplianceInquiryMetadataOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
