const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DescribeProvisioningTemplateVersionInput = struct {
    /// The template name.
    template_name: []const u8,

    /// The provisioning template version ID.
    version_id: i32,

    pub const json_field_names = .{
        .template_name = "templateName",
        .version_id = "versionId",
    };
};

pub const DescribeProvisioningTemplateVersionOutput = struct {
    /// The date when the provisioning template version was created.
    creation_date: ?i64 = null,

    /// True if the provisioning template version is the default version.
    is_default_version: ?bool = null,

    /// The JSON formatted contents of the provisioning template version.
    template_body: ?[]const u8 = null,

    /// The provisioning template version ID.
    version_id: ?i32 = null,

    pub const json_field_names = .{
        .creation_date = "creationDate",
        .is_default_version = "isDefaultVersion",
        .template_body = "templateBody",
        .version_id = "versionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeProvisioningTemplateVersionInput, options: CallOptions) !DescribeProvisioningTemplateVersionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeProvisioningTemplateVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/provisioning-templates/");
    try path_buf.appendSlice(allocator, input.template_name);
    try path_buf.appendSlice(allocator, "/versions/");
    try path_buf.appendSlice(allocator, input.version_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeProvisioningTemplateVersionOutput {
    const result: DescribeProvisioningTemplateVersionOutput = try aws.json.parseJsonObject(
        DescribeProvisioningTemplateVersionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
