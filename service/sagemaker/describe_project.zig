const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UserContext = @import("user_context.zig").UserContext;
const ProjectStatus = @import("project_status.zig").ProjectStatus;
const ServiceCatalogProvisionedProductDetails = @import("service_catalog_provisioned_product_details.zig").ServiceCatalogProvisionedProductDetails;
const ServiceCatalogProvisioningDetails = @import("service_catalog_provisioning_details.zig").ServiceCatalogProvisioningDetails;
const TemplateProviderDetail = @import("template_provider_detail.zig").TemplateProviderDetail;

pub const DescribeProjectInput = struct {
    /// The name of the project to describe.
    project_name: []const u8,

    pub const json_field_names = .{
        .project_name = "ProjectName",
    };
};

pub const DescribeProjectOutput = struct {
    created_by: ?UserContext = null,

    /// The time when the project was created.
    creation_time: i64,

    last_modified_by: ?UserContext = null,

    /// The timestamp when project was last modified.
    last_modified_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the project.
    project_arn: []const u8,

    /// The description of the project.
    project_description: ?[]const u8 = null,

    /// The ID of the project.
    project_id: []const u8,

    /// The name of the project.
    project_name: []const u8,

    /// The status of the project.
    project_status: ProjectStatus,

    /// Information about a provisioned service catalog product.
    service_catalog_provisioned_product_details: ?ServiceCatalogProvisionedProductDetails = null,

    /// Information used to provision a service catalog product. For information,
    /// see [What is Amazon Web Services Service
    /// Catalog](https://docs.aws.amazon.com/servicecatalog/latest/adminguide/introduction.html).
    service_catalog_provisioning_details: ?ServiceCatalogProvisioningDetails = null,

    /// An array of template providers associated with the project.
    template_provider_details: ?[]const TemplateProviderDetail = null,

    pub const json_field_names = .{
        .created_by = "CreatedBy",
        .creation_time = "CreationTime",
        .last_modified_by = "LastModifiedBy",
        .last_modified_time = "LastModifiedTime",
        .project_arn = "ProjectArn",
        .project_description = "ProjectDescription",
        .project_id = "ProjectId",
        .project_name = "ProjectName",
        .project_status = "ProjectStatus",
        .service_catalog_provisioned_product_details = "ServiceCatalogProvisionedProductDetails",
        .service_catalog_provisioning_details = "ServiceCatalogProvisioningDetails",
        .template_provider_details = "TemplateProviderDetails",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeProjectInput, options: CallOptions) !DescribeProjectOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeProjectInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.DescribeProject");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeProjectOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeProjectOutput, body, allocator);
}
