const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdateProvisioningParameter = @import("update_provisioning_parameter.zig").UpdateProvisioningParameter;
const UpdateProvisioningPreferences = @import("update_provisioning_preferences.zig").UpdateProvisioningPreferences;
const Tag = @import("tag.zig").Tag;
const RecordDetail = @import("record_detail.zig").RecordDetail;

pub const UpdateProvisionedProductInput = struct {
    /// The language code.
    ///
    /// * `jp` - Japanese
    ///
    /// * `zh` - Chinese
    accept_language: ?[]const u8 = null,

    /// The path identifier. This value is optional if the product
    /// has a default path, and required if the product has more than one path. You
    /// must provide the name or ID, but not both.
    path_id: ?[]const u8 = null,

    /// The name of the path. You must provide the name or ID, but not both.
    path_name: ?[]const u8 = null,

    /// The identifier of the product. You must provide the name or ID, but not
    /// both.
    product_id: ?[]const u8 = null,

    /// The name of the product. You must provide the name or ID, but not both.
    product_name: ?[]const u8 = null,

    /// The identifier of the provisioned product. You must provide the name or ID,
    /// but not both.
    provisioned_product_id: ?[]const u8 = null,

    /// The name of the provisioned product. You cannot specify both
    /// `ProvisionedProductName` and `ProvisionedProductId`.
    provisioned_product_name: ?[]const u8 = null,

    /// The identifier of the provisioning artifact.
    provisioning_artifact_id: ?[]const u8 = null,

    /// The name of the provisioning artifact. You must provide the name or ID, but
    /// not both.
    provisioning_artifact_name: ?[]const u8 = null,

    /// The new parameters.
    provisioning_parameters: ?[]const UpdateProvisioningParameter = null,

    /// An object that contains information about the provisioning preferences for a
    /// stack set.
    provisioning_preferences: ?UpdateProvisioningPreferences = null,

    /// One or more tags. Requires the product to have `RESOURCE_UPDATE` constraint
    /// with `TagUpdatesOnProvisionedProduct` set to `ALLOWED` to allow tag updates.
    tags: ?[]const Tag = null,

    /// The idempotency token that uniquely identifies the provisioning update
    /// request.
    update_token: []const u8,

    pub const json_field_names = .{
        .accept_language = "AcceptLanguage",
        .path_id = "PathId",
        .path_name = "PathName",
        .product_id = "ProductId",
        .product_name = "ProductName",
        .provisioned_product_id = "ProvisionedProductId",
        .provisioned_product_name = "ProvisionedProductName",
        .provisioning_artifact_id = "ProvisioningArtifactId",
        .provisioning_artifact_name = "ProvisioningArtifactName",
        .provisioning_parameters = "ProvisioningParameters",
        .provisioning_preferences = "ProvisioningPreferences",
        .tags = "Tags",
        .update_token = "UpdateToken",
    };
};

pub const UpdateProvisionedProductOutput = struct {
    /// Information about the result of the request.
    record_detail: ?RecordDetail = null,

    pub const json_field_names = .{
        .record_detail = "RecordDetail",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateProvisionedProductInput, options: CallOptions) !UpdateProvisionedProductOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateProvisionedProductInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWS242ServiceCatalogService.UpdateProvisionedProduct");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateProvisionedProductOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateProvisionedProductOutput, body, allocator);
}
