const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const SourceConnection = @import("source_connection.zig").SourceConnection;
const ProductViewDetail = @import("product_view_detail.zig").ProductViewDetail;

pub const UpdateProductInput = struct {
    /// The language code.
    ///
    /// * `jp` - Japanese
    ///
    /// * `zh` - Chinese
    accept_language: ?[]const u8 = null,

    /// The tags to add to the product.
    add_tags: ?[]const Tag = null,

    /// The updated description of the product.
    description: ?[]const u8 = null,

    /// The updated distributor of the product.
    distributor: ?[]const u8 = null,

    /// The product identifier.
    id: []const u8,

    /// The updated product name.
    name: ?[]const u8 = null,

    /// The updated owner of the product.
    owner: ?[]const u8 = null,

    /// The tags to remove from the product.
    remove_tags: ?[]const []const u8 = null,

    /// Specifies connection details for the updated product and syncs the product
    /// to the connection source
    /// artifact. This automatically manages the product's artifacts based on
    /// changes to the source.
    /// The `SourceConnection` parameter consists of the following sub-fields.
    ///
    /// * `Type`
    ///
    /// * `ConnectionParamters`
    source_connection: ?SourceConnection = null,

    /// The updated support description for the product.
    support_description: ?[]const u8 = null,

    /// The updated support email for the product.
    support_email: ?[]const u8 = null,

    /// The updated support URL for the product.
    support_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .accept_language = "AcceptLanguage",
        .add_tags = "AddTags",
        .description = "Description",
        .distributor = "Distributor",
        .id = "Id",
        .name = "Name",
        .owner = "Owner",
        .remove_tags = "RemoveTags",
        .source_connection = "SourceConnection",
        .support_description = "SupportDescription",
        .support_email = "SupportEmail",
        .support_url = "SupportUrl",
    };
};

pub const UpdateProductOutput = struct {
    /// Information about the product view.
    product_view_detail: ?ProductViewDetail = null,

    /// Information about the tags associated with the product.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .product_view_detail = "ProductViewDetail",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateProductInput, options: CallOptions) !UpdateProductOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateProductInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWS242ServiceCatalogService.UpdateProduct");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateProductOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateProductOutput, body, allocator);
}
