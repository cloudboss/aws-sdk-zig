const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CopyOption = @import("copy_option.zig").CopyOption;

pub const CopyProductInput = struct {
    /// The language code.
    ///
    /// * `jp` - Japanese
    ///
    /// * `zh` - Chinese
    accept_language: ?[]const u8 = null,

    /// The copy options. If the value is `CopyTags`, the tags from the source
    /// product are copied to the target product.
    copy_options: ?[]const CopyOption = null,

    /// A unique identifier that you provide to ensure idempotency. If multiple
    /// requests differ only by the idempotency token,
    /// the same response is returned for each repeated request.
    idempotency_token: []const u8,

    /// The Amazon Resource Name (ARN) of the source product.
    source_product_arn: []const u8,

    /// The identifiers of the provisioning artifacts (also known as versions) of
    /// the product to copy.
    /// By default, all provisioning artifacts are copied.
    source_provisioning_artifact_identifiers: ?[]const []const aws.map.StringMapEntry = null,

    /// The identifier of the target product. By default, a new product is created.
    target_product_id: ?[]const u8 = null,

    /// A name for the target product. The default is the name of the source
    /// product.
    target_product_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .accept_language = "AcceptLanguage",
        .copy_options = "CopyOptions",
        .idempotency_token = "IdempotencyToken",
        .source_product_arn = "SourceProductArn",
        .source_provisioning_artifact_identifiers = "SourceProvisioningArtifactIdentifiers",
        .target_product_id = "TargetProductId",
        .target_product_name = "TargetProductName",
    };
};

pub const CopyProductOutput = struct {
    /// The token to use to track the progress of the operation.
    copy_product_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .copy_product_token = "CopyProductToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CopyProductInput, options: CallOptions) !CopyProductOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CopyProductInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWS242ServiceCatalogService.CopyProduct");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CopyProductOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CopyProductOutput, body, allocator);
}
