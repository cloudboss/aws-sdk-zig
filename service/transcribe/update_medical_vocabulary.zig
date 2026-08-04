const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const LanguageCode = @import("language_code.zig").LanguageCode;
const VocabularyState = @import("vocabulary_state.zig").VocabularyState;

pub const UpdateMedicalVocabularyInput = struct {
    /// The language code that represents the language of the entries in the custom
    /// vocabulary
    /// you want to update. US English (`en-US`) is the only language supported with
    /// Amazon Transcribe Medical.
    language_code: LanguageCode,

    /// The Amazon S3 location of the text file that contains your custom medical
    /// vocabulary. The URI must be located in the same Amazon Web Services Region
    /// as the
    /// resource you're calling.
    ///
    /// Here's an example URI path:
    /// `s3://DOC-EXAMPLE-BUCKET/my-vocab-file.txt`
    vocabulary_file_uri: []const u8,

    /// The name of the custom medical vocabulary you want to update. Custom medical
    /// vocabulary names are case sensitive.
    vocabulary_name: []const u8,

    pub const json_field_names = .{
        .language_code = "LanguageCode",
        .vocabulary_file_uri = "VocabularyFileUri",
        .vocabulary_name = "VocabularyName",
    };
};

pub const UpdateMedicalVocabularyOutput = struct {
    /// The language code you selected for your custom medical vocabulary. US
    /// English
    /// (`en-US`) is the only language supported with Amazon Transcribe
    /// Medical.
    language_code: ?LanguageCode = null,

    /// The date and time the specified custom medical vocabulary was last updated.
    ///
    /// Timestamps are in the format `YYYY-MM-DD'T'HH:MM:SS.SSSSSS-UTC`. For
    /// example, `2022-05-04T12:32:58.761000-07:00` represents 12:32 PM UTC-7 on May
    /// 4, 2022.
    last_modified_time: ?i64 = null,

    /// The name of the updated custom medical vocabulary.
    vocabulary_name: ?[]const u8 = null,

    /// The processing state of your custom medical vocabulary. If the state is
    /// `READY`, you can use the custom vocabulary in a
    /// `StartMedicalTranscriptionJob` request.
    vocabulary_state: ?VocabularyState = null,

    pub const json_field_names = .{
        .language_code = "LanguageCode",
        .last_modified_time = "LastModifiedTime",
        .vocabulary_name = "VocabularyName",
        .vocabulary_state = "VocabularyState",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateMedicalVocabularyInput, options: CallOptions) !UpdateMedicalVocabularyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "transcribe", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateMedicalVocabularyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("transcribe", "Transcribe", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Transcribe.UpdateMedicalVocabulary");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateMedicalVocabularyOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateMedicalVocabularyOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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
        const parsed_error: ?errors.BadRequestException = aws.json.parseJsonObject(errors.BadRequestException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .bad_request_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        const parsed_error: ?errors.ConflictException = aws.json.parseJsonObject(errors.ConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalFailureException")) {
        const parsed_error: ?errors.InternalFailureException = aws.json.parseJsonObject(errors.InternalFailureException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_failure_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        const parsed_error: ?errors.LimitExceededException = aws.json.parseJsonObject(errors.LimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        const parsed_error: ?errors.NotFoundException = aws.json.parseJsonObject(errors.NotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .not_found_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
