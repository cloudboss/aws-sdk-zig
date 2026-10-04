const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Status = @import("status.zig").Status;

pub const GetCloudFormationTemplateInput = struct {
    /// The Amazon Resource Name (ARN) of the application.
    application_id: []const u8,

    /// The UUID returned by CreateCloudFormationTemplate.
    ///
    /// Pattern:
    /// [0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}
    template_id: []const u8,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .template_id = "TemplateId",
    };
};

pub const GetCloudFormationTemplateOutput = struct {
    /// The application Amazon Resource Name (ARN).
    application_id: ?[]const u8 = null,

    /// The date and time this resource was created.
    creation_time: ?[]const u8 = null,

    /// The date and time this template expires. Templates
    /// expire 1 hour after creation.
    expiration_time: ?[]const u8 = null,

    /// The semantic version of the application:
    ///
    /// [https://semver.org/](https://semver.org/)
    semantic_version: ?[]const u8 = null,

    /// Status of the template creation workflow.
    ///
    /// Possible values: PREPARING | ACTIVE | EXPIRED
    status: ?Status = null,

    /// The UUID returned by CreateCloudFormationTemplate.
    ///
    /// Pattern:
    /// [0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}
    template_id: ?[]const u8 = null,

    /// A link to the template that can be used to deploy the application using
    /// AWS CloudFormation.
    template_url: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .creation_time = "CreationTime",
        .expiration_time = "ExpirationTime",
        .semantic_version = "SemanticVersion",
        .status = "Status",
        .template_id = "TemplateId",
        .template_url = "TemplateUrl",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetCloudFormationTemplateInput, options: CallOptions) !GetCloudFormationTemplateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "serverlessrepo", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetCloudFormationTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("serverlessrepo", "ServerlessApplicationRepository", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/templates/");
    try path_buf.appendSlice(allocator, input.template_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetCloudFormationTemplateOutput {
    const result: GetCloudFormationTemplateOutput = try aws.json.parseJsonObject(
        GetCloudFormationTemplateOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
