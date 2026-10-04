const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TemplateVersionSourceInput = @import("template_version_source_input.zig").TemplateVersionSourceInput;
const Tag = @import("tag.zig").Tag;
const EnvironmentTemplateVersion = @import("environment_template_version.zig").EnvironmentTemplateVersion;

pub const CreateEnvironmentTemplateVersionInput = struct {
    /// When included, if two identical requests are made with the same client
    /// token, Proton returns the environment template version that the first
    /// request created.
    client_token: ?[]const u8 = null,

    /// A description of the new version of an environment template.
    description: ?[]const u8 = null,

    /// To create a new minor version of the environment template, include `major
    /// Version`.
    ///
    /// To create a new major and minor version of the environment template, exclude
    /// `major Version`.
    major_version: ?[]const u8 = null,

    /// An object that includes the template bundle S3 bucket path and name for the
    /// new version of an template.
    source: TemplateVersionSourceInput,

    /// An optional list of metadata items that you can associate with the Proton
    /// environment template version. A tag is a key-value pair.
    ///
    /// For more information, see [Proton resources and
    /// tagging](https://docs.aws.amazon.com/proton/latest/userguide/resources.html)
    /// in the
    /// *Proton User Guide*.
    tags: ?[]const Tag = null,

    /// The name of the environment template.
    template_name: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .major_version = "majorVersion",
        .source = "source",
        .tags = "tags",
        .template_name = "templateName",
    };
};

pub const CreateEnvironmentTemplateVersionOutput = struct {
    /// The environment template detail data that's returned by Proton.
    environment_template_version: ?EnvironmentTemplateVersion = null,

    pub const json_field_names = .{
        .environment_template_version = "environmentTemplateVersion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEnvironmentTemplateVersionInput, options: CallOptions) !CreateEnvironmentTemplateVersionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEnvironmentTemplateVersionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AwsProton20200720.CreateEnvironmentTemplateVersion");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEnvironmentTemplateVersionOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateEnvironmentTemplateVersionOutput, body, allocator);
}
