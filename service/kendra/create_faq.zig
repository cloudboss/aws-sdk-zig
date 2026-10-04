const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FaqFileFormat = @import("faq_file_format.zig").FaqFileFormat;
const S3Path = @import("s3_path.zig").S3Path;
const Tag = @import("tag.zig").Tag;

pub const CreateFaqInput = struct {
    /// A token that you provide to identify the request to create a FAQ. Multiple
    /// calls to
    /// the `CreateFaqRequest` API with the same client token will create only one
    /// FAQ.
    client_token: ?[]const u8 = null,

    /// A description for the FAQ.
    description: ?[]const u8 = null,

    /// The format of the FAQ input file. You can choose between a basic CSV format,
    /// a CSV
    /// format that includes customs attributes in a header, and a JSON format that
    /// includes
    /// custom attributes.
    ///
    /// The default format is CSV.
    ///
    /// The format must match the format of the file stored in the S3 bucket
    /// identified in
    /// the `S3Path` parameter.
    ///
    /// For more information, see [Adding questions and
    /// answers](https://docs.aws.amazon.com/kendra/latest/dg/in-creating-faq.html).
    file_format: ?FaqFileFormat = null,

    /// The identifier of the index for the FAQ.
    index_id: []const u8,

    /// The code for a language. This allows you to support a language
    /// for the FAQ document. English is supported by default.
    /// For more information on supported languages, including their codes,
    /// see [Adding
    /// documents in languages other than
    /// English](https://docs.aws.amazon.com/kendra/latest/dg/in-adding-languages.html).
    language_code: ?[]const u8 = null,

    /// A name for the FAQ.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of an IAM role with permission to access
    /// the S3 bucket that contains the FAQ file. For more information, see [IAM
    /// access roles for
    /// Amazon Kendra](https://docs.aws.amazon.com/kendra/latest/dg/iam-roles.html).
    role_arn: []const u8,

    /// The path to the FAQ file in S3.
    s3_path: S3Path,

    /// A list of key-value pairs that identify the FAQ. You can use the tags to
    /// identify and
    /// organize your resources and to control access to resources.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .description = "Description",
        .file_format = "FileFormat",
        .index_id = "IndexId",
        .language_code = "LanguageCode",
        .name = "Name",
        .role_arn = "RoleArn",
        .s3_path = "S3Path",
        .tags = "Tags",
    };
};

pub const CreateFaqOutput = struct {
    /// The identifier of the FAQ.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "Id",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFaqInput, options: CallOptions) !CreateFaqOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFaqInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraFrontendService.CreateFaq");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFaqOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateFaqOutput, body, allocator);
}
