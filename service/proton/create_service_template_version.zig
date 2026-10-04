const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CompatibleEnvironmentTemplateInput = @import("compatible_environment_template_input.zig").CompatibleEnvironmentTemplateInput;
const TemplateVersionSourceInput = @import("template_version_source_input.zig").TemplateVersionSourceInput;
const ServiceTemplateSupportedComponentSourceType = @import("service_template_supported_component_source_type.zig").ServiceTemplateSupportedComponentSourceType;
const Tag = @import("tag.zig").Tag;
const ServiceTemplateVersion = @import("service_template_version.zig").ServiceTemplateVersion;

pub const CreateServiceTemplateVersionInput = struct {
    /// When included, if two identical requests are made with the same client
    /// token, Proton
    /// returns the service template version that the first request created.
    client_token: ?[]const u8 = null,

    /// An array of environment template objects that are compatible with the new
    /// service template
    /// version. A service instance based on this service template version can run
    /// in environments
    /// based on compatible templates.
    compatible_environment_templates: []const CompatibleEnvironmentTemplateInput,

    /// A description of the new version of a service template.
    description: ?[]const u8 = null,

    /// To create a new minor version of the service template, include a `major
    /// Version`.
    ///
    /// To create a new major and minor version of the service template,
    /// *exclude*
    /// `major Version`.
    major_version: ?[]const u8 = null,

    /// An object that includes the template bundle S3 bucket path and name for the
    /// new version of
    /// a service template.
    source: TemplateVersionSourceInput,

    /// An array of supported component sources. Components with supported sources
    /// can be attached
    /// to service instances based on this service template version.
    ///
    /// For more information about components, see
    /// [Proton
    /// components](https://docs.aws.amazon.com/proton/latest/userguide/ag-components.html) in the
    /// *Proton User Guide*.
    supported_component_sources: ?[]const ServiceTemplateSupportedComponentSourceType = null,

    /// An optional list of metadata items that you can associate with the Proton
    /// service template
    /// version. A tag is a key-value pair.
    ///
    /// For more information, see [Proton resources and
    /// tagging](https://docs.aws.amazon.com/proton/latest/userguide/resources.html)
    /// in the
    /// *Proton User Guide*.
    tags: ?[]const Tag = null,

    /// The name of the service template.
    template_name: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .compatible_environment_templates = "compatibleEnvironmentTemplates",
        .description = "description",
        .major_version = "majorVersion",
        .source = "source",
        .supported_component_sources = "supportedComponentSources",
        .tags = "tags",
        .template_name = "templateName",
    };
};

pub const CreateServiceTemplateVersionOutput = struct {
    /// The service template version summary of detail data that's returned by
    /// Proton.
    service_template_version: ?ServiceTemplateVersion = null,

    pub const json_field_names = .{
        .service_template_version = "serviceTemplateVersion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateServiceTemplateVersionInput, options: CallOptions) !CreateServiceTemplateVersionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateServiceTemplateVersionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AwsProton20200720.CreateServiceTemplateVersion");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateServiceTemplateVersionOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateServiceTemplateVersionOutput, body, allocator);
}
