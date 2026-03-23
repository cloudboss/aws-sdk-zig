const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const DocumentReaderConfig = @import("document_reader_config.zig").DocumentReaderConfig;
const DocumentClass = @import("document_class.zig").DocumentClass;
const DocumentMetadata = @import("document_metadata.zig").DocumentMetadata;
const DocumentTypeListItem = @import("document_type_list_item.zig").DocumentTypeListItem;
const ErrorsListItem = @import("errors_list_item.zig").ErrorsListItem;
const DocumentLabel = @import("document_label.zig").DocumentLabel;
const WarningsListItem = @import("warnings_list_item.zig").WarningsListItem;

pub const ClassifyDocumentInput = struct {
    /// Use the `Bytes` parameter to input a text, PDF, Word or image file.
    ///
    /// When you classify a document using a custom model, you can also use the
    /// `Bytes` parameter to input an Amazon Textract `DetectDocumentText`
    /// or `AnalyzeDocument` output file.
    ///
    /// To classify a document using the prompt safety classifier, use the `Text`
    /// parameter for input.
    ///
    /// Provide the input document as a sequence of base64-encoded bytes.
    /// If your code uses an Amazon Web Services SDK to classify documents, the SDK
    /// may encode
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

    /// The Amazon Resource Number (ARN) of the endpoint.
    ///
    /// For prompt safety classification, Amazon Comprehend provides the endpoint
    /// ARN. For more information about prompt safety classifiers, see [Prompt
    /// safety
    /// classification](https://docs.aws.amazon.com/comprehend/latest/dg/trust-safety.html#prompt-classification) in the *Amazon Comprehend Developer Guide*
    ///
    /// For custom classification, you create an endpoint for your custom model. For
    /// more information,
    /// see [Using Amazon Comprehend
    /// endpoints](https://docs.aws.amazon.com/comprehend/latest/dg/using-endpoints.html).
    endpoint_arn: []const u8,

    /// The document text to be analyzed. If you enter text using this parameter,
    /// do not use the `Bytes` parameter.
    text: ?[]const u8 = null,

    pub const json_field_names = .{
        .bytes = "Bytes",
        .document_reader_config = "DocumentReaderConfig",
        .endpoint_arn = "EndpointArn",
        .text = "Text",
    };
};

pub const ClassifyDocumentOutput = struct {
    /// The classes used by the document being analyzed. These are used for models
    /// trained in multi-class mode.
    /// Individual classes are mutually exclusive and each document is expected to
    /// have only a
    /// single class assigned to it. For example, an animal can be a dog or a cat,
    /// but not both at the
    /// same time.
    ///
    /// For prompt safety classification, the response includes only two classes
    /// (SAFE_PROMPT and UNSAFE_PROMPT),
    /// along with a confidence score for each class. The value range of the score
    /// is zero to one, where one is the highest confidence.
    classes: ?[]const DocumentClass = null,

    /// Extraction information about the document. This field is present
    /// in the response only if your request includes the `Byte` parameter.
    document_metadata: ?DocumentMetadata = null,

    /// The document type for each page in the input document. This field is present
    /// in the response only if your request includes the `Byte` parameter.
    document_type: ?[]const DocumentTypeListItem = null,

    /// Page-level errors that the system detected while processing the input
    /// document.
    /// The field is empty if the system encountered no errors.
    errors: ?[]const ErrorsListItem = null,

    /// The labels used in the document being analyzed. These are used for
    /// multi-label trained
    /// models. Individual labels represent different categories that are related in
    /// some manner and
    /// are not mutually exclusive. For example, a movie can be just an action
    /// movie, or it can be an
    /// action movie, a science fiction movie, and a comedy, all at the same time.
    labels: ?[]const DocumentLabel = null,

    /// Warnings detected while processing the input document.
    /// The response includes a warning if there is a mismatch between the input
    /// document type
    /// and the model type associated with the endpoint that you specified. The
    /// response can also include
    /// warnings for individual pages that have a mismatch.
    ///
    /// The field is empty if the system generated no warnings.
    warnings: ?[]const WarningsListItem = null,

    pub const json_field_names = .{
        .classes = "Classes",
        .document_metadata = "DocumentMetadata",
        .document_type = "DocumentType",
        .errors = "Errors",
        .labels = "Labels",
        .warnings = "Warnings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ClassifyDocumentInput, options: CallOptions) !ClassifyDocumentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ClassifyDocumentInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Comprehend_20171127.ClassifyDocument");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ClassifyDocumentOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ClassifyDocumentOutput, body, allocator);
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
