const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProductType = @import("product_type.zig").ProductType;
const ProvisioningArtifactProperties = @import("provisioning_artifact_properties.zig").ProvisioningArtifactProperties;
const SourceConnection = @import("source_connection.zig").SourceConnection;
const Tag = @import("tag.zig").Tag;
const ProductViewDetail = @import("product_view_detail.zig").ProductViewDetail;
const ProvisioningArtifactDetail = @import("provisioning_artifact_detail.zig").ProvisioningArtifactDetail;

pub const CreateProductInput = struct {
    /// The language code.
    ///
    /// * `jp` - Japanese
    ///
    /// * `zh` - Chinese
    accept_language: ?[]const u8 = null,

    /// The description of the product.
    description: ?[]const u8 = null,

    /// The distributor of the product.
    distributor: ?[]const u8 = null,

    /// A unique identifier that you provide to ensure idempotency. If multiple
    /// requests differ only by the idempotency token,
    /// the same response is returned for each repeated request.
    idempotency_token: []const u8,

    /// The name of the product.
    name: []const u8,

    /// The owner of the product.
    owner: []const u8,

    /// The type of product.
    product_type: ProductType,

    /// The configuration of the provisioning artifact.
    provisioning_artifact_parameters: ?ProvisioningArtifactProperties = null,

    /// Specifies connection details for the created product and syncs the product
    /// to the connection source
    /// artifact. This automatically manages the product's artifacts based on
    /// changes to the source.
    /// The `SourceConnection` parameter consists of the following sub-fields.
    ///
    /// * `Type`
    ///
    /// * `ConnectionParamters`
    source_connection: ?SourceConnection = null,

    /// The support information about the product.
    support_description: ?[]const u8 = null,

    /// The contact email for product support.
    support_email: ?[]const u8 = null,

    /// The contact URL for product support.
    ///
    /// `^https?:\/\// `/ is the pattern used to validate SupportUrl.
    support_url: ?[]const u8 = null,

    /// One or more tags.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .accept_language = "AcceptLanguage",
        .description = "Description",
        .distributor = "Distributor",
        .idempotency_token = "IdempotencyToken",
        .name = "Name",
        .owner = "Owner",
        .product_type = "ProductType",
        .provisioning_artifact_parameters = "ProvisioningArtifactParameters",
        .source_connection = "SourceConnection",
        .support_description = "SupportDescription",
        .support_email = "SupportEmail",
        .support_url = "SupportUrl",
        .tags = "Tags",
    };
};

pub const CreateProductOutput = struct {
    /// Information about the product view.
    product_view_detail: ?ProductViewDetail = null,

    /// Information about the provisioning artifact.
    provisioning_artifact_detail: ?ProvisioningArtifactDetail = null,

    /// Information about the tags associated with the product.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .product_view_detail = "ProductViewDetail",
        .provisioning_artifact_detail = "ProvisioningArtifactDetail",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateProductInput, options: CallOptions) !CreateProductOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateProductInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWS242ServiceCatalogService.CreateProduct");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateProductOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateProductOutput, body, allocator);
}
