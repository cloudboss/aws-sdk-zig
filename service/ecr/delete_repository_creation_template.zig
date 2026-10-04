const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RepositoryCreationTemplate = @import("repository_creation_template.zig").RepositoryCreationTemplate;

pub const DeleteRepositoryCreationTemplateInput = struct {
    /// The repository namespace prefix associated with the repository creation
    /// template.
    prefix: []const u8,

    pub const json_field_names = .{
        .prefix = "prefix",
    };
};

pub const DeleteRepositoryCreationTemplateOutput = struct {
    /// The registry ID associated with the request.
    registry_id: ?[]const u8 = null,

    /// The details of the repository creation template that was deleted.
    repository_creation_template: ?RepositoryCreationTemplate = null,

    pub const json_field_names = .{
        .registry_id = "registryId",
        .repository_creation_template = "repositoryCreationTemplate",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteRepositoryCreationTemplateInput, options: CallOptions) !DeleteRepositoryCreationTemplateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ecr", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteRepositoryCreationTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.ecr", "ECR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerRegistry_V20150921.DeleteRepositoryCreationTemplate");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteRepositoryCreationTemplateOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeleteRepositoryCreationTemplateOutput, body, allocator);
}
