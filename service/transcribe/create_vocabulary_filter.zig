const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const LanguageCode = @import("language_code.zig").LanguageCode;
const Tag = @import("tag.zig").Tag;

pub const CreateVocabularyFilterInput = struct {
    /// The Amazon Resource Name (ARN) of an IAM role that has permissions to
    /// access the Amazon S3 bucket that contains your input files (in this case,
    /// your custom
    /// vocabulary filter). If the role that you specify doesn’t have the
    /// appropriate permissions to access
    /// the specified Amazon S3 location, your request fails.
    ///
    /// IAM role ARNs have the format
    /// `arn:partition:iam::account:role/role-name-with-path`. For example:
    /// `arn:aws:iam::111122223333:role/Admin`.
    ///
    /// For more information, see [IAM
    /// ARNs](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_identifiers.html#identifiers-arns).
    data_access_role_arn: ?[]const u8 = null,

    /// The language code that represents the language of the entries in your
    /// vocabulary
    /// filter. Each custom vocabulary filter must contain terms in only one
    /// language.
    ///
    /// A custom vocabulary filter can only be used to transcribe files in the same
    /// language
    /// as the filter. For example, if you create a custom vocabulary filter using
    /// US English
    /// (`en-US`), you can only apply this filter to files that contain English
    /// audio.
    ///
    /// For a list of supported languages and their associated language codes, refer
    /// to the
    /// [Supported
    /// languages](https://docs.aws.amazon.com/transcribe/latest/dg/supported-languages.html) table.
    language_code: LanguageCode,

    /// Adds one or more custom tags, each in the form of a key:value pair, to a new
    /// custom
    /// vocabulary filter at the time you create this new vocabulary filter.
    ///
    /// To learn more about using tags with Amazon Transcribe, refer to [Tagging
    /// resources](https://docs.aws.amazon.com/transcribe/latest/dg/tagging.html).
    tags: ?[]const Tag = null,

    /// The Amazon S3 location of the text file that contains your custom vocabulary
    /// filter terms. The URI must be located in the same Amazon Web Services Region
    /// as the
    /// resource you're calling.
    ///
    /// Here's an example URI path:
    /// `s3://DOC-EXAMPLE-BUCKET/my-vocab-filter-file.txt`
    ///
    /// Note that if you include `VocabularyFilterFileUri` in your request, you
    /// cannot use `Words`; you must choose one or the other.
    vocabulary_filter_file_uri: ?[]const u8 = null,

    /// A unique name, chosen by you, for your new custom vocabulary filter.
    ///
    /// This name is case sensitive, cannot contain spaces, and must be unique
    /// within an
    /// Amazon Web Services account. If you try to create a new custom vocabulary
    /// filter with
    /// the same name as an existing custom vocabulary filter, you get a
    /// `ConflictException` error.
    vocabulary_filter_name: []const u8,

    /// Use this parameter if you want to create your custom vocabulary filter by
    /// including
    /// all desired terms, as comma-separated values, within your request. The other
    /// option for
    /// creating your vocabulary filter is to save your entries in a text file and
    /// upload them
    /// to an Amazon S3 bucket, then specify the location of your file using the
    /// `VocabularyFilterFileUri` parameter.
    ///
    /// Note that if you include `Words` in your request, you cannot use
    /// `VocabularyFilterFileUri`; you must choose one or the other.
    ///
    /// Each language has a character set that contains all allowed characters for
    /// that
    /// specific language. If you use unsupported characters, your custom vocabulary
    /// filter
    /// request fails. Refer to [Character Sets for Custom
    /// Vocabularies](https://docs.aws.amazon.com/transcribe/latest/dg/charsets.html) to get the character set for your language.
    words: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .data_access_role_arn = "DataAccessRoleArn",
        .language_code = "LanguageCode",
        .tags = "Tags",
        .vocabulary_filter_file_uri = "VocabularyFilterFileUri",
        .vocabulary_filter_name = "VocabularyFilterName",
        .words = "Words",
    };
};

pub const CreateVocabularyFilterOutput = struct {
    /// The language code you selected for your custom vocabulary filter.
    language_code: ?LanguageCode = null,

    /// The date and time you created your custom vocabulary filter.
    ///
    /// Timestamps are in the format `YYYY-MM-DD'T'HH:MM:SS.SSSSSS-UTC`. For
    /// example, `2022-05-04T12:32:58.761000-07:00` represents 12:32 PM UTC-7 on May
    /// 4, 2022.
    last_modified_time: ?i64 = null,

    /// The name you chose for your custom vocabulary filter.
    vocabulary_filter_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .language_code = "LanguageCode",
        .last_modified_time = "LastModifiedTime",
        .vocabulary_filter_name = "VocabularyFilterName",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateVocabularyFilterInput, options: Options) !CreateVocabularyFilterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "transcribe");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateVocabularyFilterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("transcribe", "Transcribe", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Transcribe.CreateVocabularyFilter");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateVocabularyFilterOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateVocabularyFilterOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalFailureException")) {
        return .{ .arena = arena, .kind = .{ .internal_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
