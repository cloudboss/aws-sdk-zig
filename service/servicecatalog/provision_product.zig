const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProvisioningParameter = @import("provisioning_parameter.zig").ProvisioningParameter;
const ProvisioningPreferences = @import("provisioning_preferences.zig").ProvisioningPreferences;
const Tag = @import("tag.zig").Tag;
const RecordDetail = @import("record_detail.zig").RecordDetail;

pub const ProvisionProductInput = struct {
    /// The language code.
    ///
    /// * `jp` - Japanese
    ///
    /// * `zh` - Chinese
    accept_language: ?[]const u8 = null,

    /// Passed to CloudFormation. The SNS topic ARNs to which to publish
    /// stack-related
    /// events.
    notification_arns: ?[]const []const u8 = null,

    /// The path identifier of the product. This value is optional if the product
    /// has a default path, and required if the product has more than one path.
    /// To list the paths for a product, use ListLaunchPaths. You must provide the
    /// name or ID, but not both.
    path_id: ?[]const u8 = null,

    /// The name of the path. You must provide the name or ID, but not both.
    path_name: ?[]const u8 = null,

    /// The product identifier. You must provide the name or ID, but not both.
    product_id: ?[]const u8 = null,

    /// The name of the product. You must provide the name or ID, but not both.
    product_name: ?[]const u8 = null,

    /// A user-friendly name for the provisioned product. This value must be
    /// unique for the Amazon Web Services account and cannot be updated after the
    /// product is provisioned.
    provisioned_product_name: []const u8,

    /// The identifier of the provisioning artifact. You must provide the name or
    /// ID, but not both.
    provisioning_artifact_id: ?[]const u8 = null,

    /// The name of the provisioning artifact. You must provide the name or ID, but
    /// not both.
    provisioning_artifact_name: ?[]const u8 = null,

    /// Parameters specified by the administrator that are required for provisioning
    /// the
    /// product.
    provisioning_parameters: ?[]const ProvisioningParameter = null,

    /// An object that contains information about the provisioning preferences for a
    /// stack set.
    provisioning_preferences: ?ProvisioningPreferences = null,

    /// An idempotency token that uniquely identifies the provisioning request.
    provision_token: []const u8,

    /// One or more tags.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .accept_language = "AcceptLanguage",
        .notification_arns = "NotificationArns",
        .path_id = "PathId",
        .path_name = "PathName",
        .product_id = "ProductId",
        .product_name = "ProductName",
        .provisioned_product_name = "ProvisionedProductName",
        .provisioning_artifact_id = "ProvisioningArtifactId",
        .provisioning_artifact_name = "ProvisioningArtifactName",
        .provisioning_parameters = "ProvisioningParameters",
        .provisioning_preferences = "ProvisioningPreferences",
        .provision_token = "ProvisionToken",
        .tags = "Tags",
    };
};

pub const ProvisionProductOutput = struct {
    /// Information about the result of provisioning the product.
    record_detail: ?RecordDetail = null,

    pub const json_field_names = .{
        .record_detail = "RecordDetail",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ProvisionProductInput, options: CallOptions) !ProvisionProductOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ProvisionProductInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWS242ServiceCatalogService.ProvisionProduct");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ProvisionProductOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ProvisionProductOutput, body, allocator);
}
