const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProvisionedProductPlanType = @import("provisioned_product_plan_type.zig").ProvisionedProductPlanType;
const UpdateProvisioningParameter = @import("update_provisioning_parameter.zig").UpdateProvisioningParameter;
const Tag = @import("tag.zig").Tag;

pub const CreateProvisionedProductPlanInput = struct {
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

    /// Passed to CloudFormation. The SNS topic ARNs to which to publish
    /// stack-related
    /// events.
    notification_arns: ?[]const []const u8 = null,

    /// The path identifier of the product. This value is optional if the product
    /// has a default path, and required if the product has more than one path.
    /// To list the paths for a product, use ListLaunchPaths.
    path_id: ?[]const u8 = null,

    /// The name of the plan.
    plan_name: []const u8,

    /// The plan type.
    plan_type: ProvisionedProductPlanType,

    /// The product identifier.
    product_id: []const u8,

    /// A user-friendly name for the provisioned product. This value must be
    /// unique for the Amazon Web Services account and cannot be updated after the
    /// product is provisioned.
    provisioned_product_name: []const u8,

    /// The identifier of the provisioning artifact.
    provisioning_artifact_id: []const u8,

    /// Parameters specified by the administrator that are required for provisioning
    /// the
    /// product.
    provisioning_parameters: ?[]const UpdateProvisioningParameter = null,

    /// One or more tags.
    ///
    /// If the plan is for an existing provisioned product, the product must have a
    /// `RESOURCE_UPDATE` constraint with `TagUpdatesOnProvisionedProduct` set to
    /// `ALLOWED` to allow tag updates.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .accept_language = "AcceptLanguage",
        .idempotency_token = "IdempotencyToken",
        .notification_arns = "NotificationArns",
        .path_id = "PathId",
        .plan_name = "PlanName",
        .plan_type = "PlanType",
        .product_id = "ProductId",
        .provisioned_product_name = "ProvisionedProductName",
        .provisioning_artifact_id = "ProvisioningArtifactId",
        .provisioning_parameters = "ProvisioningParameters",
        .tags = "Tags",
    };
};

pub const CreateProvisionedProductPlanOutput = struct {
    /// The plan identifier.
    plan_id: ?[]const u8 = null,

    /// The name of the plan.
    plan_name: ?[]const u8 = null,

    /// The user-friendly name of the provisioned product.
    provisioned_product_name: ?[]const u8 = null,

    /// The identifier of the provisioning artifact.
    provisioning_artifact_id: ?[]const u8 = null,

    /// The product identifier.
    provision_product_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .plan_id = "PlanId",
        .plan_name = "PlanName",
        .provisioned_product_name = "ProvisionedProductName",
        .provisioning_artifact_id = "ProvisioningArtifactId",
        .provision_product_id = "ProvisionProductId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateProvisionedProductPlanInput, options: CallOptions) !CreateProvisionedProductPlanOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateProvisionedProductPlanInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWS242ServiceCatalogService.CreateProvisionedProductPlan");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateProvisionedProductPlanOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateProvisionedProductPlanOutput, body, allocator);
}
