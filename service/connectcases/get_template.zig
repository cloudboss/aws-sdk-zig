const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LayoutConfiguration = @import("layout_configuration.zig").LayoutConfiguration;
const RequiredField = @import("required_field.zig").RequiredField;
const TemplateRule = @import("template_rule.zig").TemplateRule;
const TemplateStatus = @import("template_status.zig").TemplateStatus;
const TagPropagationConfiguration = @import("tag_propagation_configuration.zig").TagPropagationConfiguration;

pub const GetTemplateInput = struct {
    /// The unique identifier of the Cases domain.
    domain_id: []const u8,

    /// A unique identifier of a template.
    template_id: []const u8,

    pub const json_field_names = .{
        .domain_id = "domainId",
        .template_id = "templateId",
    };
};

pub const GetTemplateOutput = struct {
    /// Timestamp at which the resource was created.
    created_time: ?i64 = null,

    /// Denotes whether or not the resource has been deleted.
    deleted: ?bool = null,

    /// A brief description of the template.
    description: ?[]const u8 = null,

    /// Timestamp at which the resource was created or last modified.
    last_modified_time: ?i64 = null,

    /// Configuration of layouts associated to the template.
    layout_configuration: ?LayoutConfiguration = null,

    /// The name of the template.
    name: []const u8,

    /// A list of fields that must contain a value for a case to be successfully
    /// created with this template.
    required_fields: ?[]const RequiredField = null,

    /// A list of case rules (also known as [case field
    /// conditions](https://docs.aws.amazon.com/connect/latest/adminguide/case-field-conditions.html)) on a template.
    rules: ?[]const TemplateRule = null,

    /// The status of the template.
    status: TemplateStatus,

    /// Defines tag propagation configuration for resources created within a domain.
    /// Tags specified here will be automatically applied to resources being created
    /// for the specified resource type.
    tag_propagation_configurations: ?[]const TagPropagationConfiguration = null,

    /// A map of of key-value pairs that represent tags on a resource. Tags are used
    /// to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The Amazon Resource Name (ARN) of the template.
    template_arn: []const u8,

    /// A unique identifier of a template.
    template_id: []const u8,

    pub const json_field_names = .{
        .created_time = "createdTime",
        .deleted = "deleted",
        .description = "description",
        .last_modified_time = "lastModifiedTime",
        .layout_configuration = "layoutConfiguration",
        .name = "name",
        .required_fields = "requiredFields",
        .rules = "rules",
        .status = "status",
        .tag_propagation_configurations = "tagPropagationConfigurations",
        .tags = "tags",
        .template_arn = "templateArn",
        .template_id = "templateId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTemplateInput, options: CallOptions) !GetTemplateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cases", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cases", "ConnectCases", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_id);
    try path_buf.appendSlice(allocator, "/templates/");
    try path_buf.appendSlice(allocator, input.template_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTemplateOutput {
    var result: GetTemplateOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetTemplateOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
