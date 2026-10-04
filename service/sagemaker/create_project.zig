const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServiceCatalogProvisioningDetails = @import("service_catalog_provisioning_details.zig").ServiceCatalogProvisioningDetails;
const Tag = @import("tag.zig").Tag;
const CreateTemplateProvider = @import("create_template_provider.zig").CreateTemplateProvider;

pub const CreateProjectInput = struct {
    /// A description for the project.
    project_description: ?[]const u8 = null,

    /// The name of the project.
    project_name: []const u8,

    /// The product ID and provisioning artifact ID to provision a service catalog.
    /// The provisioning artifact ID will default to the latest provisioning
    /// artifact ID of the product, if you don't provide the provisioning artifact
    /// ID. For more information, see [What is Amazon Web Services Service
    /// Catalog](https://docs.aws.amazon.com/servicecatalog/latest/adminguide/introduction.html).
    service_catalog_provisioning_details: ?ServiceCatalogProvisioningDetails = null,

    /// An array of key-value pairs that you want to use to organize and track your
    /// Amazon Web Services resource costs. For more information, see [Tagging
    /// Amazon Web Services
    /// resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    /// in the *Amazon Web Services General Reference Guide*.
    tags: ?[]const Tag = null,

    /// An array of template provider configurations for creating infrastructure
    /// resources for the project.
    template_providers: ?[]const CreateTemplateProvider = null,

    pub const json_field_names = .{
        .project_description = "ProjectDescription",
        .project_name = "ProjectName",
        .service_catalog_provisioning_details = "ServiceCatalogProvisioningDetails",
        .tags = "Tags",
        .template_providers = "TemplateProviders",
    };
};

pub const CreateProjectOutput = struct {
    /// The Amazon Resource Name (ARN) of the project.
    project_arn: []const u8,

    /// The ID of the new project.
    project_id: []const u8,

    pub const json_field_names = .{
        .project_arn = "ProjectArn",
        .project_id = "ProjectId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateProjectInput, options: CallOptions) !CreateProjectOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateProjectInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateProject");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateProjectOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateProjectOutput, body, allocator);
}
