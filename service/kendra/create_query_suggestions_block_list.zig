const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const S3Path = @import("s3_path.zig").S3Path;
const Tag = @import("tag.zig").Tag;

pub const CreateQuerySuggestionsBlockListInput = struct {
    /// A token that you provide to identify the request to create a
    /// query suggestions block list.
    client_token: ?[]const u8 = null,

    /// A description for the block list.
    ///
    /// For example, the description "List of all offensive words that can
    /// appear in user queries and need to be blocked from suggestions."
    description: ?[]const u8 = null,

    /// The identifier of the index you want to create a query suggestions block
    /// list for.
    index_id: []const u8,

    /// A name for the block list.
    ///
    /// For example, the name 'offensive-words', which includes all
    /// offensive words that could appear in user queries and need to be
    /// blocked from suggestions.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of an IAM role with permission to
    /// access your S3 bucket that contains the block list text file. For more
    /// information,
    /// see [IAM access roles for
    /// Amazon Kendra](https://docs.aws.amazon.com/kendra/latest/dg/iam-roles.html).
    role_arn: []const u8,

    /// The S3 path to your block list text file in your S3 bucket.
    ///
    /// Each block word or phrase should be on a separate line in a text file.
    ///
    /// For information on the current quota limits for block lists, see
    /// [Quotas
    /// for Amazon
    /// Kendra](https://docs.aws.amazon.com/kendra/latest/dg/quotas.html).
    source_s3_path: S3Path,

    /// A list of key-value pairs that identify or categorize the block list.
    /// Tag keys and values can consist of Unicode letters, digits, white space,
    /// and any of the following symbols: _ . : / = + - @.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .description = "Description",
        .index_id = "IndexId",
        .name = "Name",
        .role_arn = "RoleArn",
        .source_s3_path = "SourceS3Path",
        .tags = "Tags",
    };
};

pub const CreateQuerySuggestionsBlockListOutput = struct {
    /// The identifier of the block list.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "Id",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateQuerySuggestionsBlockListInput, options: CallOptions) !CreateQuerySuggestionsBlockListOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kendra", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateQuerySuggestionsBlockListInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kendra", "kendra", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraFrontendService.CreateQuerySuggestionsBlockList");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateQuerySuggestionsBlockListOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateQuerySuggestionsBlockListOutput, body, allocator);
}
