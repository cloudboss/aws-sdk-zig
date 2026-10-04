const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CertificateFilterStatement = @import("certificate_filter_statement.zig").CertificateFilterStatement;
const SearchCertificatesSortBy = @import("search_certificates_sort_by.zig").SearchCertificatesSortBy;
const SearchCertificatesSortOrder = @import("search_certificates_sort_order.zig").SearchCertificatesSortOrder;
const CertificateSearchResult = @import("certificate_search_result.zig").CertificateSearchResult;

pub const SearchCertificatesInput = struct {
    /// A filter statement that defines the search criteria. You can combine
    /// multiple filters using AND, OR, and NOT logical operators to create complex
    /// queries.
    filter_statement: ?CertificateFilterStatement = null,

    /// The maximum number of results to return in the response. Default is 100.
    max_results: ?i32 = null,

    /// Use this parameter only when paginating results and only in a subsequent
    /// request after you receive a response with truncated results. Set it to the
    /// value of `NextToken` from the response you just received.
    next_token: ?[]const u8 = null,

    /// Specifies the field to sort results by. Valid values are CREATED_AT,
    /// NOT_AFTER, STATUS, RENEWAL_STATUS, EXPORTED, IN_USE, NOT_BEFORE,
    /// KEY_ALGORITHM, TYPE, CERTIFICATE_ARN, COMMON_NAME, REVOKED_AT,
    /// RENEWAL_ELIGIBILITY, ISSUED_AT, MANAGED_BY, EXPORT_OPTION,
    /// VALIDATION_METHOD, and IMPORTED_AT.
    sort_by: ?SearchCertificatesSortBy = null,

    /// Specifies the order of sorted results. Valid values are ASCENDING or
    /// DESCENDING.
    sort_order: ?SearchCertificatesSortOrder = null,

    pub const json_field_names = .{
        .filter_statement = "FilterStatement",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};

pub const SearchCertificatesOutput = struct {
    /// When the list is truncated, this value is present and contains the value to
    /// use for the `NextToken` parameter in a subsequent pagination request.
    next_token: ?[]const u8 = null,

    /// A list of certificate search results containing certificate ARNs, X.509
    /// attributes, and ACM metadata.
    results: ?[]const CertificateSearchResult = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .results = "Results",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchCertificatesInput, options: CallOptions) !SearchCertificatesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchCertificatesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "CertificateManager.SearchCertificates");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchCertificatesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(SearchCertificatesOutput, body, allocator);
}
