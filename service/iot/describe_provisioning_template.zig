const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProvisioningHook = @import("provisioning_hook.zig").ProvisioningHook;
const TemplateType = @import("template_type.zig").TemplateType;

pub const DescribeProvisioningTemplateInput = struct {
    /// The name of the provisioning template.
    template_name: []const u8,

    pub const json_field_names = .{
        .template_name = "templateName",
    };
};

pub const DescribeProvisioningTemplateOutput = struct {
    /// The date when the provisioning template was created.
    creation_date: ?i64 = null,

    /// The default fleet template version ID.
    default_version_id: ?i32 = null,

    /// The description of the provisioning template.
    description: ?[]const u8 = null,

    /// True if the provisioning template is enabled, otherwise false.
    enabled: ?bool = null,

    /// The date when the provisioning template was last modified.
    last_modified_date: ?i64 = null,

    /// Gets information about a pre-provisioned hook.
    pre_provisioning_hook: ?ProvisioningHook = null,

    /// The ARN of the role associated with the provisioning template. This IoT role
    /// grants
    /// permission to provision a device.
    provisioning_role_arn: ?[]const u8 = null,

    /// The ARN of the provisioning template.
    template_arn: ?[]const u8 = null,

    /// The JSON formatted contents of the provisioning template.
    template_body: ?[]const u8 = null,

    /// The name of the provisioning template.
    template_name: ?[]const u8 = null,

    /// The type you define in a provisioning template. You can create a template
    /// with only one type.
    /// You can't change the template type after its creation. The default value is
    /// `FLEET_PROVISIONING`.
    /// For more information about provisioning template, see: [Provisioning
    /// template](https://docs.aws.amazon.com/iot/latest/developerguide/provision-template.html).
    @"type": ?TemplateType = null,

    pub const json_field_names = .{
        .creation_date = "creationDate",
        .default_version_id = "defaultVersionId",
        .description = "description",
        .enabled = "enabled",
        .last_modified_date = "lastModifiedDate",
        .pre_provisioning_hook = "preProvisioningHook",
        .provisioning_role_arn = "provisioningRoleArn",
        .template_arn = "templateArn",
        .template_body = "templateBody",
        .template_name = "templateName",
        .@"type" = "type",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeProvisioningTemplateInput, options: CallOptions) !DescribeProvisioningTemplateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeProvisioningTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/provisioning-templates/");
    try path_buf.appendSlice(allocator, input.template_name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeProvisioningTemplateOutput {
    const result: DescribeProvisioningTemplateOutput = try aws.json.parseJsonObject(
        DescribeProvisioningTemplateOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
