const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const S3Path = @import("s3_path.zig").S3Path;
const QuerySuggestionsBlockListStatus = @import("query_suggestions_block_list_status.zig").QuerySuggestionsBlockListStatus;

pub const DescribeQuerySuggestionsBlockListInput = struct {
    /// The identifier of the block list you want to get information on.
    id: []const u8,

    /// The identifier of the index for the block list.
    index_id: []const u8,

    pub const json_field_names = .{
        .id = "Id",
        .index_id = "IndexId",
    };
};

pub const DescribeQuerySuggestionsBlockListOutput = struct {
    /// The Unix timestamp when a block list for query suggestions was created.
    created_at: ?i64 = null,

    /// The description for the block list.
    description: ?[]const u8 = null,

    /// The error message containing details if there are issues processing
    /// the block list.
    error_message: ?[]const u8 = null,

    /// The current size of the block list text file in S3.
    file_size_bytes: ?i64 = null,

    /// The identifier of the block list.
    id: ?[]const u8 = null,

    /// The identifier of the index for the block list.
    index_id: ?[]const u8 = null,

    /// The current number of valid, non-empty words or phrases in
    /// the block list text file.
    item_count: ?i32 = null,

    /// The name of the block list.
    name: ?[]const u8 = null,

    /// The IAM (Identity and Access Management) role used by
    /// Amazon Kendra to access the block list text file in S3.
    ///
    /// The role needs S3 read permissions to your file in S3 and needs to
    /// give STS (Security Token Service) assume role permissions to
    /// Amazon Kendra.
    role_arn: ?[]const u8 = null,

    /// Shows the current S3 path to your block list text file in your S3 bucket.
    ///
    /// Each block word or phrase should be on a separate line in a text file.
    ///
    /// For information on the current quota limits for block lists, see
    /// [Quotas
    /// for Amazon
    /// Kendra](https://docs.aws.amazon.com/kendra/latest/dg/quotas.html).
    source_s3_path: ?S3Path = null,

    /// The current status of the block list. When the value is
    /// `ACTIVE`, the block list is ready for use.
    status: ?QuerySuggestionsBlockListStatus = null,

    /// The Unix timestamp when a block list for query suggestions was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .description = "Description",
        .error_message = "ErrorMessage",
        .file_size_bytes = "FileSizeBytes",
        .id = "Id",
        .index_id = "IndexId",
        .item_count = "ItemCount",
        .name = "Name",
        .role_arn = "RoleArn",
        .source_s3_path = "SourceS3Path",
        .status = "Status",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeQuerySuggestionsBlockListInput, options: CallOptions) !DescribeQuerySuggestionsBlockListOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeQuerySuggestionsBlockListInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraFrontendService.DescribeQuerySuggestionsBlockList");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeQuerySuggestionsBlockListOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeQuerySuggestionsBlockListOutput, body, allocator);
}
