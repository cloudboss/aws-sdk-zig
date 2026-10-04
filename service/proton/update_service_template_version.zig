const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CompatibleEnvironmentTemplateInput = @import("compatible_environment_template_input.zig").CompatibleEnvironmentTemplateInput;
const TemplateVersionStatus = @import("template_version_status.zig").TemplateVersionStatus;
const ServiceTemplateSupportedComponentSourceType = @import("service_template_supported_component_source_type.zig").ServiceTemplateSupportedComponentSourceType;
const ServiceTemplateVersion = @import("service_template_version.zig").ServiceTemplateVersion;

pub const UpdateServiceTemplateVersionInput = struct {
    /// An array of environment template objects that are compatible with this
    /// service template
    /// version. A service instance based on this service template version can run
    /// in environments
    /// based on compatible templates.
    compatible_environment_templates: ?[]const CompatibleEnvironmentTemplateInput = null,

    /// A description of a service template version to update.
    description: ?[]const u8 = null,

    /// To update a major version of a service template, include `major
    /// Version`.
    major_version: []const u8,

    /// To update a minor version of a service template, include `minorVersion`.
    minor_version: []const u8,

    /// The status of the service template minor version to update.
    status: ?TemplateVersionStatus = null,

    /// An array of supported component sources. Components with supported sources
    /// can be attached
    /// to service instances based on this service template version.
    ///
    /// A change to `supportedComponentSources` doesn't impact existing component
    /// attachments to instances based on this template version. A change only
    /// affects later
    /// associations.
    ///
    /// For more information about components, see
    /// [Proton
    /// components](https://docs.aws.amazon.com/proton/latest/userguide/ag-components.html) in the
    /// *Proton User Guide*.
    supported_component_sources: ?[]const ServiceTemplateSupportedComponentSourceType = null,

    /// The name of the service template.
    template_name: []const u8,

    pub const json_field_names = .{
        .compatible_environment_templates = "compatibleEnvironmentTemplates",
        .description = "description",
        .major_version = "majorVersion",
        .minor_version = "minorVersion",
        .status = "status",
        .supported_component_sources = "supportedComponentSources",
        .template_name = "templateName",
    };
};

pub const UpdateServiceTemplateVersionOutput = struct {
    /// The service template version detail data that's returned by Proton.
    service_template_version: ?ServiceTemplateVersion = null,

    pub const json_field_names = .{
        .service_template_version = "serviceTemplateVersion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateServiceTemplateVersionInput, options: CallOptions) !UpdateServiceTemplateVersionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateServiceTemplateVersionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AwsProton20200720.UpdateServiceTemplateVersion");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateServiceTemplateVersionOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateServiceTemplateVersionOutput, body, allocator);
}
