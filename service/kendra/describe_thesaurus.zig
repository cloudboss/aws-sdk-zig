const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const S3Path = @import("s3_path.zig").S3Path;
const ThesaurusStatus = @import("thesaurus_status.zig").ThesaurusStatus;

pub const DescribeThesaurusInput = struct {
    /// The identifier of the thesaurus you want to get information on.
    id: []const u8,

    /// The identifier of the index for the thesaurus.
    index_id: []const u8,

    pub const json_field_names = .{
        .id = "Id",
        .index_id = "IndexId",
    };
};

pub const DescribeThesaurusOutput = struct {
    /// The Unix timestamp when the thesaurus was created.
    created_at: ?i64 = null,

    /// The thesaurus description.
    description: ?[]const u8 = null,

    /// When the `Status` field value is `FAILED`, the
    /// `ErrorMessage` field provides more information.
    error_message: ?[]const u8 = null,

    /// The size of the thesaurus file in bytes.
    file_size_bytes: ?i64 = null,

    /// The identifier of the thesaurus.
    id: ?[]const u8 = null,

    /// The identifier of the index for the thesaurus.
    index_id: ?[]const u8 = null,

    /// The thesaurus name.
    name: ?[]const u8 = null,

    /// An IAM role that gives Amazon Kendra permissions
    /// to access thesaurus file specified in `SourceS3Path`.
    role_arn: ?[]const u8 = null,

    source_s3_path: ?S3Path = null,

    /// The current status of the thesaurus. When the value is `ACTIVE`,
    /// queries are able to use the thesaurus. If the `Status` field value
    /// is `FAILED`, the `ErrorMessage` field provides
    /// more information.
    ///
    /// If the status is `ACTIVE_BUT_UPDATE_FAILED`, it means
    /// that Amazon Kendra could not ingest the new thesaurus file. The old
    /// thesaurus file is still active.
    status: ?ThesaurusStatus = null,

    /// The number of synonym rules in the thesaurus file.
    synonym_rule_count: ?i64 = null,

    /// The number of unique terms in the thesaurus file. For example, the
    /// synonyms `a,b,c` and `a=>d`, the term
    /// count would be 4.
    term_count: ?i64 = null,

    /// The Unix timestamp when the thesaurus was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .description = "Description",
        .error_message = "ErrorMessage",
        .file_size_bytes = "FileSizeBytes",
        .id = "Id",
        .index_id = "IndexId",
        .name = "Name",
        .role_arn = "RoleArn",
        .source_s3_path = "SourceS3Path",
        .status = "Status",
        .synonym_rule_count = "SynonymRuleCount",
        .term_count = "TermCount",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeThesaurusInput, options: CallOptions) !DescribeThesaurusOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeThesaurusInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraFrontendService.DescribeThesaurus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeThesaurusOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeThesaurusOutput, body, allocator);
}
