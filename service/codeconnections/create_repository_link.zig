const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const RepositoryLinkInfo = @import("repository_link_info.zig").RepositoryLinkInfo;

pub const CreateRepositoryLinkInput = struct {
    /// The Amazon Resource Name (ARN) of the connection to be associated with the
    /// repository link.
    connection_arn: []const u8,

    /// The Amazon Resource Name (ARN) encryption key for the repository to be
    /// associated with the repository link.
    encryption_key_arn: ?[]const u8 = null,

    /// The owner ID for the repository associated with a specific sync
    /// configuration, such as
    /// the owner ID in GitHub.
    owner_id: []const u8,

    /// The name of the repository to be associated with the repository link.
    repository_name: []const u8,

    /// The tags for the repository to be associated with the repository link.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .connection_arn = "ConnectionArn",
        .encryption_key_arn = "EncryptionKeyArn",
        .owner_id = "OwnerId",
        .repository_name = "RepositoryName",
        .tags = "Tags",
    };
};

pub const CreateRepositoryLinkOutput = struct {
    /// The returned information about the created repository link.
    repository_link_info: ?RepositoryLinkInfo = null,

    pub const json_field_names = .{
        .repository_link_info = "RepositoryLinkInfo",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRepositoryLinkInput, options: CallOptions) !CreateRepositoryLinkOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codeconnections", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRepositoryLinkInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeconnections", "CodeConnections", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "CodeConnections_20231201.CreateRepositoryLink");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRepositoryLinkOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateRepositoryLinkOutput, body, allocator);
}
