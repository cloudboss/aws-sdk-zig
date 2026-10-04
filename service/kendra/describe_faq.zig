const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FaqFileFormat = @import("faq_file_format.zig").FaqFileFormat;
const S3Path = @import("s3_path.zig").S3Path;
const FaqStatus = @import("faq_status.zig").FaqStatus;

pub const DescribeFaqInput = struct {
    /// The identifier of the FAQ you want to get information on.
    id: []const u8,

    /// The identifier of the index for the FAQ.
    index_id: []const u8,

    pub const json_field_names = .{
        .id = "Id",
        .index_id = "IndexId",
    };
};

pub const DescribeFaqOutput = struct {
    /// The Unix timestamp when the FAQ was created.
    created_at: ?i64 = null,

    /// The description of the FAQ that you provided when it was created.
    description: ?[]const u8 = null,

    /// If the `Status` field is `FAILED`, the `ErrorMessage`
    /// field contains the reason why the FAQ failed.
    error_message: ?[]const u8 = null,

    /// The file format used for the FAQ file.
    file_format: ?FaqFileFormat = null,

    /// The identifier of the FAQ.
    id: ?[]const u8 = null,

    /// The identifier of the index for the FAQ.
    index_id: ?[]const u8 = null,

    /// The code for a language. This shows a supported language
    /// for the FAQ document. English is supported by default.
    /// For more information on supported languages, including their codes,
    /// see [Adding
    /// documents in languages other than
    /// English](https://docs.aws.amazon.com/kendra/latest/dg/in-adding-languages.html).
    language_code: ?[]const u8 = null,

    /// The name that you gave the FAQ when it was created.
    name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role that provides access
    /// to the S3 bucket containing the FAQ file.
    role_arn: ?[]const u8 = null,

    s3_path: ?S3Path = null,

    /// The status of the FAQ. It is ready to use when the status is
    /// `ACTIVE`.
    status: ?FaqStatus = null,

    /// The Unix timestamp when the FAQ was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .description = "Description",
        .error_message = "ErrorMessage",
        .file_format = "FileFormat",
        .id = "Id",
        .index_id = "IndexId",
        .language_code = "LanguageCode",
        .name = "Name",
        .role_arn = "RoleArn",
        .s3_path = "S3Path",
        .status = "Status",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeFaqInput, options: CallOptions) !DescribeFaqOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeFaqInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraFrontendService.DescribeFaq");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeFaqOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeFaqOutput, body, allocator);
}
