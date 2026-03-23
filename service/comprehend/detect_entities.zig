const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const DocumentReaderConfig = @import("document_reader_config.zig").DocumentReaderConfig;
const LanguageCode = @import("language_code.zig").LanguageCode;
const Block = @import("block.zig").Block;
const DocumentMetadata = @import("document_metadata.zig").DocumentMetadata;
const DocumentTypeListItem = @import("document_type_list_item.zig").DocumentTypeListItem;
const Entity = @import("entity.zig").Entity;
const ErrorsListItem = @import("errors_list_item.zig").ErrorsListItem;

pub const DetectEntitiesInput = struct {
    /// This field applies only when you use a custom entity recognition model that
    /// was trained with PDF annotations. For other cases,
    /// enter your text input in the `Text` field.
    ///
    /// Use the `Bytes` parameter to input a text, PDF, Word or image file.
    /// Using a plain-text file in the `Bytes` parameter is equivelent to using the
    /// `Text` parameter (the `Entities` field in the response is identical).
    ///
    /// You can also use the `Bytes` parameter to input an Amazon Textract
    /// `DetectDocumentText`
    /// or `AnalyzeDocument` output file.
    ///
    /// Provide the input document as a sequence of base64-encoded bytes.
    /// If your code uses an Amazon Web Services SDK to detect entities, the SDK may
    /// encode
    /// the document file bytes for you.
    ///
    /// The maximum length of this field depends on the input document type. For
    /// details, see
    /// [
    /// Inputs for real-time custom
    /// analysis](https://docs.aws.amazon.com/comprehend/latest/dg/idp-inputs-sync.html) in the Comprehend Developer Guide.
    ///
    /// If you use the `Bytes` parameter, do not use the `Text` parameter.
    bytes: ?[]const u8 = null,

    /// Provides configuration parameters to override the default actions for
    /// extracting text
    /// from PDF documents and image files.
    document_reader_config: ?DocumentReaderConfig = null,

    /// The Amazon Resource Name of an endpoint that is associated with a custom
    /// entity
    /// recognition model. Provide an endpoint if you want to detect entities by
    /// using your own custom
    /// model instead of the default model that is used by Amazon Comprehend.
    ///
    /// If you specify an endpoint, Amazon Comprehend uses the language of your
    /// custom model, and
    /// it ignores any language code that you provide in your request.
    ///
    /// For information about endpoints, see [Managing
    /// endpoints](https://docs.aws.amazon.com/comprehend/latest/dg/manage-endpoints.html).
    endpoint_arn: ?[]const u8 = null,

    /// The language of the input documents. You can specify any of the primary
    /// languages
    /// supported by Amazon Comprehend. If your request includes the endpoint for a
    /// custom entity recognition model, Amazon
    /// Comprehend uses the language of your custom model, and it ignores any
    /// language code that you
    /// specify here.
    ///
    /// All input documents must be in the same language.
    language_code: ?LanguageCode = null,

    /// A UTF-8 text string. The maximum string size is 100 KB. If you enter text
    /// using this parameter,
    /// do not use the `Bytes` parameter.
    text: ?[]const u8 = null,

    pub const json_field_names = .{
        .bytes = "Bytes",
        .document_reader_config = "DocumentReaderConfig",
        .endpoint_arn = "EndpointArn",
        .language_code = "LanguageCode",
        .text = "Text",
    };
};

pub const DetectEntitiesOutput = struct {
    /// Information about each block of text in the input document.
    /// Blocks are nested. A page block contains a block for each line of text,
    /// which contains a block for each word.
    ///
    /// The `Block` content for a Word input document does not include a `Geometry`
    /// field.
    ///
    /// The `Block` field is not present in the response for plain-text inputs.
    blocks: ?[]const Block = null,

    /// Information about the document, discovered during text extraction. This
    /// field is present
    /// in the response only if your request used the `Byte` parameter.
    document_metadata: ?DocumentMetadata = null,

    /// The document type for each page in the input document. This field is present
    /// in the response only if your request used the `Byte` parameter.
    document_type: ?[]const DocumentTypeListItem = null,

    /// A collection of entities identified in the input text. For each entity, the
    /// response
    /// provides the entity text, entity type, where the entity text begins and
    /// ends, and the level of
    /// confidence that Amazon Comprehend has in the detection.
    ///
    /// If your request uses a custom entity recognition model, Amazon Comprehend
    /// detects the
    /// entities that the model is trained to recognize. Otherwise, it detects the
    /// default entity
    /// types. For a list of default entity types, see
    /// [Entities](https://docs.aws.amazon.com/comprehend/latest/dg/how-entities.html) in the Comprehend Developer Guide.
    entities: ?[]const Entity = null,

    /// Page-level errors that the system detected while processing the input
    /// document.
    /// The field is empty if the system encountered no errors.
    errors: ?[]const ErrorsListItem = null,

    pub const json_field_names = .{
        .blocks = "Blocks",
        .document_metadata = "DocumentMetadata",
        .document_type = "DocumentType",
        .entities = "Entities",
        .errors = "Errors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DetectEntitiesInput, options: CallOptions) !DetectEntitiesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "comprehend");

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

fn serializeRequest(allocator: std.mem.Allocator, input: DetectEntitiesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("comprehend", "Comprehend", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "Comprehend_20171127.DetectEntities");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DetectEntitiesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DetectEntitiesOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "BatchSizeLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .batch_size_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidFilterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_filter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "JobNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .job_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KmsKeyValidationException")) {
        return .{ .arena = arena, .kind = .{ .kms_key_validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .resource_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TextSizeLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .text_size_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagKeysException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tag_keys_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedLanguageException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_language_exception = .{
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
