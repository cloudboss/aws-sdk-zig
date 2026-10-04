const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateProvisioningTemplateVersionInput = struct {
    /// Sets a fleet provision template version as the default version.
    set_as_default: ?bool = null,

    /// The JSON formatted contents of the provisioning template.
    template_body: []const u8,

    /// The name of the provisioning template.
    template_name: []const u8,

    pub const json_field_names = .{
        .set_as_default = "setAsDefault",
        .template_body = "templateBody",
        .template_name = "templateName",
    };
};

pub const CreateProvisioningTemplateVersionOutput = struct {
    /// True if the provisioning template version is the default version, otherwise
    /// false.
    is_default_version: ?bool = null,

    /// The ARN that identifies the provisioning template.
    template_arn: ?[]const u8 = null,

    /// The name of the provisioning template.
    template_name: ?[]const u8 = null,

    /// The version of the provisioning template.
    version_id: ?i32 = null,

    pub const json_field_names = .{
        .is_default_version = "isDefaultVersion",
        .template_arn = "templateArn",
        .template_name = "templateName",
        .version_id = "versionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateProvisioningTemplateVersionInput, options: CallOptions) !CreateProvisioningTemplateVersionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateProvisioningTemplateVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/provisioning-templates/");
    try path_buf.appendSlice(allocator, input.template_name);
    try path_buf.appendSlice(allocator, "/versions");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.set_as_default) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "setAsDefault=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"templateBody\":");
    try aws.json.writeValue(@TypeOf(input.template_body), input.template_body, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateProvisioningTemplateVersionOutput {
    const result: CreateProvisioningTemplateVersionOutput = try aws.json.parseJsonObject(
        CreateProvisioningTemplateVersionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
