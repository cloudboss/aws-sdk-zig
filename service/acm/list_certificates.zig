const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CertificateStatus = @import("certificate_status.zig").CertificateStatus;
const Filters = @import("filters.zig").Filters;
const SortBy = @import("sort_by.zig").SortBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const CertificateSummary = @import("certificate_summary.zig").CertificateSummary;

pub const ListCertificatesInput = struct {
    /// Filter the certificate list by status value.
    certificate_statuses: ?[]const CertificateStatus = null,

    /// Filter the certificate list. For more information, see the Filters
    /// structure.
    includes: ?Filters = null,

    /// Use this parameter when paginating results to specify the maximum number of
    /// items to return in the response. If additional items exist beyond the number
    /// you specify, the `NextToken` element is sent in the response. Use this
    /// `NextToken` value in a subsequent request to retrieve additional items.
    max_items: ?i32 = null,

    /// Use this parameter only when paginating results and only in a subsequent
    /// request after you receive a response with truncated results. Set it to the
    /// value of `NextToken` from the response you just received.
    next_token: ?[]const u8 = null,

    /// Specifies the field to sort results by. If you specify `SortBy`, you must
    /// also specify `SortOrder`.
    sort_by: ?SortBy = null,

    /// Specifies the order of sorted results. If you specify `SortOrder`, you must
    /// also specify `SortBy`.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .certificate_statuses = "CertificateStatuses",
        .includes = "Includes",
        .max_items = "MaxItems",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};

pub const ListCertificatesOutput = struct {
    /// A list of ACM certificates.
    certificate_summary_list: ?[]const CertificateSummary = null,

    /// When the list is truncated, this value is present and contains the value to
    /// use for the `NextToken` parameter in a subsequent pagination request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificate_summary_list = "CertificateSummaryList",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListCertificatesInput, options: CallOptions) !ListCertificatesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "acm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListCertificatesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("acm", "ACM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CertificateManager.ListCertificates");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListCertificatesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListCertificatesOutput, body, allocator);
}
