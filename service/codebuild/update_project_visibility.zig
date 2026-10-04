const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProjectVisibilityType = @import("project_visibility_type.zig").ProjectVisibilityType;

pub const UpdateProjectVisibilityInput = struct {
    /// The Amazon Resource Name (ARN) of the build project.
    project_arn: []const u8,

    project_visibility: ProjectVisibilityType,

    /// The ARN of the IAM role that enables CodeBuild to access the CloudWatch Logs
    /// and Amazon S3 artifacts for
    /// the project's builds.
    resource_access_role: ?[]const u8 = null,

    pub const json_field_names = .{
        .project_arn = "projectArn",
        .project_visibility = "projectVisibility",
        .resource_access_role = "resourceAccessRole",
    };
};

pub const UpdateProjectVisibilityOutput = struct {
    /// The Amazon Resource Name (ARN) of the build project.
    project_arn: ?[]const u8 = null,

    project_visibility: ?ProjectVisibilityType = null,

    /// Contains the project identifier used with the public build APIs.
    public_project_alias: ?[]const u8 = null,

    pub const json_field_names = .{
        .project_arn = "projectArn",
        .project_visibility = "projectVisibility",
        .public_project_alias = "publicProjectAlias",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateProjectVisibilityInput, options: CallOptions) !UpdateProjectVisibilityOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codebuild", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateProjectVisibilityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codebuild", "CodeBuild", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodeBuild_20161006.UpdateProjectVisibility");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateProjectVisibilityOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateProjectVisibilityOutput, body, allocator);
}
