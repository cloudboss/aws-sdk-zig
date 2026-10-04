const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServiceCatalogProvisioningUpdateDetails = @import("service_catalog_provisioning_update_details.zig").ServiceCatalogProvisioningUpdateDetails;
const Tag = @import("tag.zig").Tag;
const UpdateTemplateProvider = @import("update_template_provider.zig").UpdateTemplateProvider;

pub const UpdateProjectInput = struct {
    /// The description for the project.
    project_description: ?[]const u8 = null,

    /// The name of the project.
    project_name: []const u8,

    /// The product ID and provisioning artifact ID to provision a service catalog.
    /// The provisioning artifact ID will default to the latest provisioning
    /// artifact ID of the product, if you don't provide the provisioning artifact
    /// ID. For more information, see [What is Amazon Web Services Service
    /// Catalog](https://docs.aws.amazon.com/servicecatalog/latest/adminguide/introduction.html).
    service_catalog_provisioning_update_details: ?ServiceCatalogProvisioningUpdateDetails = null,

    /// An array of key-value pairs. You can use tags to categorize your Amazon Web
    /// Services resources in different ways, for example, by purpose, owner, or
    /// environment. For more information, see [Tagging Amazon Web Services
    /// Resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html).
    /// In addition, the project must have tag update constraints set in order to
    /// include this parameter in the request. For more information, see [Amazon Web
    /// Services Service Catalog Tag Update
    /// Constraints](https://docs.aws.amazon.com/servicecatalog/latest/adminguide/constraints-resourceupdate.html).
    tags: ?[]const Tag = null,

    /// The template providers to update in the project.
    template_providers_to_update: ?[]const UpdateTemplateProvider = null,

    pub const json_field_names = .{
        .project_description = "ProjectDescription",
        .project_name = "ProjectName",
        .service_catalog_provisioning_update_details = "ServiceCatalogProvisioningUpdateDetails",
        .tags = "Tags",
        .template_providers_to_update = "TemplateProvidersToUpdate",
    };
};

pub const UpdateProjectOutput = struct {
    /// The Amazon Resource Name (ARN) of the project.
    project_arn: []const u8,

    pub const json_field_names = .{
        .project_arn = "ProjectArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateProjectInput, options: CallOptions) !UpdateProjectOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateProjectInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.UpdateProject");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateProjectOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateProjectOutput, body, allocator);
}
