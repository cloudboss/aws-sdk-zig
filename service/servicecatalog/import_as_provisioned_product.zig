const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RecordDetail = @import("record_detail.zig").RecordDetail;

pub const ImportAsProvisionedProductInput = struct {
    /// The language code.
    ///
    /// * `jp` - Japanese
    ///
    /// * `zh` - Chinese
    accept_language: ?[]const u8 = null,

    /// A unique identifier that you provide to ensure idempotency. If multiple
    /// requests differ only by the idempotency token,
    /// the same response is returned for each repeated request.
    idempotency_token: []const u8,

    /// The unique identifier of the resource to be imported. It only currently
    /// supports
    /// CloudFormation stack IDs.
    physical_id: []const u8,

    /// The product identifier.
    product_id: []const u8,

    /// The user-friendly name of the provisioned product. The value must be unique
    /// for the Amazon Web Services account.
    /// The name cannot be updated after the product is provisioned.
    provisioned_product_name: []const u8,

    /// The identifier of the provisioning artifact.
    provisioning_artifact_id: []const u8,

    pub const json_field_names = .{
        .accept_language = "AcceptLanguage",
        .idempotency_token = "IdempotencyToken",
        .physical_id = "PhysicalId",
        .product_id = "ProductId",
        .provisioned_product_name = "ProvisionedProductName",
        .provisioning_artifact_id = "ProvisioningArtifactId",
    };
};

pub const ImportAsProvisionedProductOutput = struct {
    record_detail: ?RecordDetail = null,

    pub const json_field_names = .{
        .record_detail = "RecordDetail",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportAsProvisionedProductInput, options: CallOptions) !ImportAsProvisionedProductOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ImportAsProvisionedProductInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWS242ServiceCatalogService.ImportAsProvisionedProduct");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ImportAsProvisionedProductOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ImportAsProvisionedProductOutput, body, allocator);
}
