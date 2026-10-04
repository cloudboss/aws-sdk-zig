const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RecordDetail = @import("record_detail.zig").RecordDetail;

pub const TerminateProvisionedProductInput = struct {
    /// The language code.
    ///
    /// * `jp` - Japanese
    ///
    /// * `zh` - Chinese
    accept_language: ?[]const u8 = null,

    /// If set to true, Service Catalog stops managing the specified provisioned
    /// product even
    /// if it cannot delete the underlying resources.
    ignore_errors: ?bool = null,

    /// The identifier of the provisioned product. You cannot specify both
    /// `ProvisionedProductName` and `ProvisionedProductId`.
    provisioned_product_id: ?[]const u8 = null,

    /// The name of the provisioned product. You cannot specify both
    /// `ProvisionedProductName` and `ProvisionedProductId`.
    provisioned_product_name: ?[]const u8 = null,

    /// When this boolean parameter is set to true, the
    /// `TerminateProvisionedProduct` API deletes
    /// the Service Catalog provisioned product. However, it does not remove the
    /// CloudFormation
    /// stack, stack set, or the underlying resources of the deleted provisioned
    /// product. The
    /// default value is false.
    retain_physical_resources: ?bool = null,

    /// An idempotency token that uniquely identifies the termination request. This
    /// token is
    /// only valid during the termination process. After the provisioned product is
    /// terminated,
    /// subsequent requests to terminate the same provisioned product always return
    /// **ResourceNotFound**.
    terminate_token: []const u8,

    pub const json_field_names = .{
        .accept_language = "AcceptLanguage",
        .ignore_errors = "IgnoreErrors",
        .provisioned_product_id = "ProvisionedProductId",
        .provisioned_product_name = "ProvisionedProductName",
        .retain_physical_resources = "RetainPhysicalResources",
        .terminate_token = "TerminateToken",
    };
};

pub const TerminateProvisionedProductOutput = struct {
    /// Information about the result of this request.
    record_detail: ?RecordDetail = null,

    pub const json_field_names = .{
        .record_detail = "RecordDetail",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TerminateProvisionedProductInput, options: CallOptions) !TerminateProvisionedProductOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: TerminateProvisionedProductInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWS242ServiceCatalogService.TerminateProvisionedProduct");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TerminateProvisionedProductOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(TerminateProvisionedProductOutput, body, allocator);
}
