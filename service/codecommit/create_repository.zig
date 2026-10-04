const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RepositoryMetadata = @import("repository_metadata.zig").RepositoryMetadata;

pub const CreateRepositoryInput = struct {
    /// The ID of the encryption key. You can view the ID of an encryption key in
    /// the KMS console, or use the KMS APIs to
    /// programmatically retrieve a key ID. For more information about acceptable
    /// values for kmsKeyID, see
    /// [KeyId](https://docs.aws.amazon.com/kms/latest/APIReference/API_Decrypt.html#KMS-Decrypt-request-KeyId) in the Decrypt API description in
    /// the *Key Management Service API Reference*.
    ///
    /// If no key is specified, the default `aws/codecommit` Amazon Web Services
    /// managed key is used.
    kms_key_id: ?[]const u8 = null,

    /// A comment or description about the new repository.
    ///
    /// The description field for a repository accepts all HTML characters and all
    /// valid
    /// Unicode characters. Applications that do not HTML-encode the description and
    /// display
    /// it in a webpage can expose users to potentially malicious code. Make sure
    /// that you
    /// HTML-encode the description field in any application that uses this API to
    /// display
    /// the repository description on a webpage.
    repository_description: ?[]const u8 = null,

    /// The name of the new repository to be created.
    ///
    /// The repository name must be unique across the calling Amazon Web Services
    /// account. Repository names
    /// are limited to 100 alphanumeric, dash, and underscore characters, and cannot
    /// include
    /// certain characters. For more information about the limits on repository
    /// names, see
    /// [Quotas](https://docs.aws.amazon.com/codecommit/latest/userguide/limits.html) in the *CodeCommit User Guide*. The
    /// suffix .git is prohibited.
    repository_name: []const u8,

    /// One or more tag key-value pairs to use when tagging this repository.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .kms_key_id = "kmsKeyId",
        .repository_description = "repositoryDescription",
        .repository_name = "repositoryName",
        .tags = "tags",
    };
};

pub const CreateRepositoryOutput = struct {
    /// Information about the newly created repository.
    repository_metadata: ?RepositoryMetadata = null,

    pub const json_field_names = .{
        .repository_metadata = "repositoryMetadata",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRepositoryInput, options: CallOptions) !CreateRepositoryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "codecommit", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRepositoryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codecommit", "CodeCommit", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CodeCommit_20150413.CreateRepository");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRepositoryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateRepositoryOutput, body, allocator);
}
