const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BudgetDetail = @import("budget_detail.zig").BudgetDetail;
const ProductViewDetail = @import("product_view_detail.zig").ProductViewDetail;
const ProvisioningArtifactSummary = @import("provisioning_artifact_summary.zig").ProvisioningArtifactSummary;
const TagOptionDetail = @import("tag_option_detail.zig").TagOptionDetail;
const Tag = @import("tag.zig").Tag;

pub const DescribeProductAsAdminInput = struct {
    /// The language code.
    ///
    /// * `jp` - Japanese
    ///
    /// * `zh` - Chinese
    accept_language: ?[]const u8 = null,

    /// The product identifier.
    id: ?[]const u8 = null,

    /// The product name.
    name: ?[]const u8 = null,

    /// The unique identifier of the shared portfolio that the specified product is
    /// associated
    /// with.
    ///
    /// You can provide this parameter to retrieve the shared TagOptions associated
    /// with the
    /// product. If this parameter is provided and if TagOptions sharing is enabled
    /// in the
    /// portfolio share, the API returns both local and shared TagOptions associated
    /// with the
    /// product. Otherwise only local TagOptions will be returned.
    source_portfolio_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .accept_language = "AcceptLanguage",
        .id = "Id",
        .name = "Name",
        .source_portfolio_id = "SourcePortfolioId",
    };
};

pub const DescribeProductAsAdminOutput = struct {
    /// Information about the associated budgets.
    budgets: ?[]const BudgetDetail = null,

    /// Information about the product view.
    product_view_detail: ?ProductViewDetail = null,

    /// Information about the provisioning artifacts (also known as versions) for
    /// the specified product.
    provisioning_artifact_summaries: ?[]const ProvisioningArtifactSummary = null,

    /// Information about the TagOptions associated with the product.
    tag_options: ?[]const TagOptionDetail = null,

    /// Information about the tags associated with the product.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .budgets = "Budgets",
        .product_view_detail = "ProductViewDetail",
        .provisioning_artifact_summaries = "ProvisioningArtifactSummaries",
        .tag_options = "TagOptions",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeProductAsAdminInput, options: CallOptions) !DescribeProductAsAdminOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeProductAsAdminInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWS242ServiceCatalogService.DescribeProductAsAdmin");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeProductAsAdminOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeProductAsAdminOutput, body, allocator);
}
