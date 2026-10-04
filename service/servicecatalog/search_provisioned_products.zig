const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccessLevelFilter = @import("access_level_filter.zig").AccessLevelFilter;
const SortOrder = @import("sort_order.zig").SortOrder;
const ProvisionedProductAttribute = @import("provisioned_product_attribute.zig").ProvisionedProductAttribute;

pub const SearchProvisionedProductsInput = struct {
    /// The language code.
    ///
    /// * `jp` - Japanese
    ///
    /// * `zh` - Chinese
    accept_language: ?[]const u8 = null,

    /// The access level to use to obtain results. The default is
    /// `Account`.
    access_level_filter: ?AccessLevelFilter = null,

    /// The search filters.
    ///
    /// When the key is `SearchQuery`, the searchable fields are `arn`,
    /// `createdTime`, `id`, `lastRecordId`,
    /// `idempotencyToken`, `name`, `physicalId`, `productId`,
    /// `provisioningArtifactId`, `type`, `status`,
    /// `tags`, `userArn`, `userArnSession`, `lastProvisioningRecordId`,
    /// `lastSuccessfulProvisioningRecordId`,
    /// `productName`, and `provisioningArtifactName`.
    ///
    /// Example: `"SearchQuery":["status:AVAILABLE"]`
    filters: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// The maximum number of items to return with this call.
    page_size: ?i32 = null,

    /// The page token for the next set of results. To retrieve the first set of
    /// results, use null.
    page_token: ?[]const u8 = null,

    /// The sort field. If no value is specified, the results are not sorted. The
    /// valid values are `arn`, `id`, `name`,
    /// and `lastRecordId`.
    sort_by: ?[]const u8 = null,

    /// The sort order. If no value is specified, the results are not sorted.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .accept_language = "AcceptLanguage",
        .access_level_filter = "AccessLevelFilter",
        .filters = "Filters",
        .page_size = "PageSize",
        .page_token = "PageToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};

pub const SearchProvisionedProductsOutput = struct {
    /// The page token to use to retrieve the next set of results. If there are no
    /// additional results, this value is null.
    next_page_token: ?[]const u8 = null,

    /// Information about the provisioned products.
    provisioned_products: ?[]const ProvisionedProductAttribute = null,

    /// The number of provisioned products found.
    total_results_count: ?i32 = null,

    pub const json_field_names = .{
        .next_page_token = "NextPageToken",
        .provisioned_products = "ProvisionedProducts",
        .total_results_count = "TotalResultsCount",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchProvisionedProductsInput, options: CallOptions) !SearchProvisionedProductsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "servicecatalog", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchProvisionedProductsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("servicecatalog", "Service Catalog", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWS242ServiceCatalogService.SearchProvisionedProducts");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchProvisionedProductsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(SearchProvisionedProductsOutput, body, allocator);
}
