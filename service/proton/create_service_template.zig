const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Provisioning = @import("provisioning.zig").Provisioning;
const Tag = @import("tag.zig").Tag;
const ServiceTemplate = @import("service_template.zig").ServiceTemplate;

pub const CreateServiceTemplateInput = struct {
    /// A description of the service template.
    description: ?[]const u8 = null,

    /// The name of the service template as displayed in the developer interface.
    display_name: ?[]const u8 = null,

    /// A customer provided encryption key that's used to encrypt data.
    encryption_key: ?[]const u8 = null,

    /// The name of the service template.
    name: []const u8,

    /// By default, Proton provides a service pipeline for your service. When this
    /// parameter is
    /// included, it indicates that an Proton service pipeline *isn't* provided
    /// for your service. After it's included, it *can't* be changed. For more
    /// information, see [Template
    /// bundles](https://docs.aws.amazon.com/proton/latest/userguide/ag-template-authoring.html#ag-template-bundles) in the *Proton User Guide*.
    pipeline_provisioning: ?Provisioning = null,

    /// An optional list of metadata items that you can associate with the Proton
    /// service template.
    /// A tag is a key-value pair.
    ///
    /// For more information, see [Proton resources and
    /// tagging](https://docs.aws.amazon.com/proton/latest/userguide/resources.html)
    /// in the
    /// *Proton User Guide*.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .description = "description",
        .display_name = "displayName",
        .encryption_key = "encryptionKey",
        .name = "name",
        .pipeline_provisioning = "pipelineProvisioning",
        .tags = "tags",
    };
};

pub const CreateServiceTemplateOutput = struct {
    /// The service template detail data that's returned by Proton.
    service_template: ?ServiceTemplate = null,

    pub const json_field_names = .{
        .service_template = "serviceTemplate",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateServiceTemplateInput, options: CallOptions) !CreateServiceTemplateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsproton20200720", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateServiceTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("proton", "Proton", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AwsProton20200720.CreateServiceTemplate");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateServiceTemplateOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateServiceTemplateOutput, body, allocator);
}
