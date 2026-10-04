const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProvisioningHook = @import("provisioning_hook.zig").ProvisioningHook;
const Tag = @import("tag.zig").Tag;
const TemplateType = @import("template_type.zig").TemplateType;

pub const CreateProvisioningTemplateInput = struct {
    /// The description of the provisioning template.
    description: ?[]const u8 = null,

    /// True to enable the provisioning template, otherwise false.
    enabled: ?bool = null,

    /// Creates a pre-provisioning hook template. Only supports template of type
    /// `FLEET_PROVISIONING`. For more information about provisioning template
    /// types,
    /// see
    /// [type](https://docs.aws.amazon.com/iot/latest/apireference/API_CreateProvisioningTemplate.html#iot-CreateProvisioningTemplate-request-type).
    pre_provisioning_hook: ?ProvisioningHook = null,

    /// The role ARN for the role associated with the provisioning template. This
    /// IoT role
    /// grants permission to provision a device.
    provisioning_role_arn: []const u8,

    /// Metadata which can be used to manage the provisioning template.
    ///
    /// For URI Request parameters use format: ...key1=value1&key2=value2...
    ///
    /// For the CLI command-line parameter use format: &&tags
    /// "key1=value1&key2=value2..."
    ///
    /// For the cli-input-json file use format: "tags":
    /// "key1=value1&key2=value2..."
    tags: ?[]const Tag = null,

    /// The JSON formatted contents of the provisioning template.
    template_body: []const u8,

    /// The name of the provisioning template.
    template_name: []const u8,

    /// The type you define in a provisioning template. You can create a template
    /// with only one type.
    /// You can't change the template type after its creation. The default value is
    /// `FLEET_PROVISIONING`.
    /// For more information about provisioning template, see: [Provisioning
    /// template](https://docs.aws.amazon.com/iot/latest/developerguide/provision-template.html).
    @"type": ?TemplateType = null,

    pub const json_field_names = .{
        .description = "description",
        .enabled = "enabled",
        .pre_provisioning_hook = "preProvisioningHook",
        .provisioning_role_arn = "provisioningRoleArn",
        .tags = "tags",
        .template_body = "templateBody",
        .template_name = "templateName",
        .@"type" = "type",
    };
};

pub const CreateProvisioningTemplateOutput = struct {
    /// The default version of the provisioning template.
    default_version_id: ?i32 = null,

    /// The ARN that identifies the provisioning template.
    template_arn: ?[]const u8 = null,

    /// The name of the provisioning template.
    template_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .default_version_id = "defaultVersionId",
        .template_arn = "templateArn",
        .template_name = "templateName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateProvisioningTemplateInput, options: CallOptions) !CreateProvisioningTemplateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateProvisioningTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/provisioning-templates";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.enabled) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"enabled\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.pre_provisioning_hook) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"preProvisioningHook\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"provisioningRoleArn\":");
    try aws.json.writeValue(@TypeOf(input.provisioning_role_arn), input.provisioning_role_arn, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"templateBody\":");
    try aws.json.writeValue(@TypeOf(input.template_body), input.template_body, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"templateName\":");
    try aws.json.writeValue(@TypeOf(input.template_name), input.template_name, allocator, &body_buf);
    has_prev = true;
    if (input.@"type") |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"type\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateProvisioningTemplateOutput {
    const result: CreateProvisioningTemplateOutput = try aws.json.parseJsonObject(
        CreateProvisioningTemplateOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
