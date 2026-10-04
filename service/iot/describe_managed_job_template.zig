const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DocumentParameter = @import("document_parameter.zig").DocumentParameter;

pub const DescribeManagedJobTemplateInput = struct {
    /// The unique name of a managed job template, which is required.
    template_name: []const u8,

    /// An optional parameter to specify version of a managed template. If not
    /// specified, the
    /// pre-defined default version is returned.
    template_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .template_name = "templateName",
        .template_version = "templateVersion",
    };
};

pub const DescribeManagedJobTemplateOutput = struct {
    /// The unique description of a managed template.
    description: ?[]const u8 = null,

    /// The document schema for a managed job template.
    document: ?[]const u8 = null,

    /// A map of key-value pairs that you can use as guidance to specify the inputs
    /// for
    /// creating a job from a managed template.
    ///
    /// `documentParameters` can only be used when creating jobs from Amazon Web
    /// Services
    /// managed templates. This parameter can't be used with custom job templates or
    /// to
    /// create jobs from them.
    document_parameters: ?[]const DocumentParameter = null,

    /// A list of environments that are supported with the managed job template.
    environments: ?[]const []const u8 = null,

    /// The unique Amazon Resource Name (ARN) of the managed template.
    template_arn: ?[]const u8 = null,

    /// The unique name of a managed template, such as `AWS-Reboot`.
    template_name: ?[]const u8 = null,

    /// The version for a managed template.
    template_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "description",
        .document = "document",
        .document_parameters = "documentParameters",
        .environments = "environments",
        .template_arn = "templateArn",
        .template_name = "templateName",
        .template_version = "templateVersion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeManagedJobTemplateInput, options: CallOptions) !DescribeManagedJobTemplateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeManagedJobTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/managed-job-templates/");
    try path_buf.appendSlice(allocator, input.template_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.template_version) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "templateVersion=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeManagedJobTemplateOutput {
    const result: DescribeManagedJobTemplateOutput = try aws.json.parseJsonObject(
        DescribeManagedJobTemplateOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
