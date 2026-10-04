const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BudgetDetail = @import("budget_detail.zig").BudgetDetail;
const LaunchPath = @import("launch_path.zig").LaunchPath;
const ProductViewSummary = @import("product_view_summary.zig").ProductViewSummary;
const ProvisioningArtifact = @import("provisioning_artifact.zig").ProvisioningArtifact;

pub const DescribeProductInput = struct {
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

    pub const json_field_names = .{
        .accept_language = "AcceptLanguage",
        .id = "Id",
        .name = "Name",
    };
};

pub const DescribeProductOutput = struct {
    /// Information about the associated budgets.
    budgets: ?[]const BudgetDetail = null,

    /// Information about the associated launch paths.
    launch_paths: ?[]const LaunchPath = null,

    /// Summary information about the product view.
    product_view_summary: ?ProductViewSummary = null,

    /// Information about the provisioning artifacts for the specified product.
    provisioning_artifacts: ?[]const ProvisioningArtifact = null,

    pub const json_field_names = .{
        .budgets = "Budgets",
        .launch_paths = "LaunchPaths",
        .product_view_summary = "ProductViewSummary",
        .provisioning_artifacts = "ProvisioningArtifacts",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeProductInput, options: CallOptions) !DescribeProductOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeProductInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWS242ServiceCatalogService.DescribeProduct");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeProductOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeProductOutput, body, allocator);
}
