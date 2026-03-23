const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const DocumentClassifierInputDataConfig = @import("document_classifier_input_data_config.zig").DocumentClassifierInputDataConfig;
const LanguageCode = @import("language_code.zig").LanguageCode;
const DocumentClassifierMode = @import("document_classifier_mode.zig").DocumentClassifierMode;
const DocumentClassifierOutputDataConfig = @import("document_classifier_output_data_config.zig").DocumentClassifierOutputDataConfig;
const Tag = @import("tag.zig").Tag;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

pub const CreateDocumentClassifierInput = struct {
    /// A unique identifier for the request. If you don't set the client request
    /// token, Amazon
    /// Comprehend generates one.
    client_request_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role that
    /// grants Amazon Comprehend read access to your input data.
    data_access_role_arn: []const u8,

    /// The name of the document classifier.
    document_classifier_name: []const u8,

    /// Specifies the format and location of the input data for the job.
    input_data_config: DocumentClassifierInputDataConfig,

    /// The language of the input documents. You can specify any of the languages
    /// supported by Amazon Comprehend. All documents must be in the same language.
    language_code: LanguageCode,

    /// Indicates the mode in which the classifier will be trained. The classifier
    /// can be trained
    /// in multi-class (single-label) mode or multi-label mode.
    /// Multi-class mode identifies a single class label for each document and
    /// multi-label mode identifies one or more class labels for each document.
    /// Multiple
    /// labels for an individual document are separated by a delimiter. The default
    /// delimiter between
    /// labels is a pipe (|).
    mode: ?DocumentClassifierMode = null,

    /// ID for the KMS key that Amazon Comprehend uses to encrypt
    /// trained custom models. The ModelKmsKeyId can be either of the following
    /// formats:
    ///
    /// * KMS Key ID: `"1234abcd-12ab-34cd-56ef-1234567890ab"`
    ///
    /// * Amazon Resource Name (ARN) of a KMS Key:
    /// `"arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"`
    model_kms_key_id: ?[]const u8 = null,

    /// The resource-based policy to attach to your custom document classifier
    /// model. You can use
    /// this policy to allow another Amazon Web Services account to import your
    /// custom model.
    ///
    /// Provide your policy as a JSON body that you enter as a UTF-8 encoded string
    /// without line
    /// breaks. To provide valid JSON, enclose the attribute names and values in
    /// double quotes. If the
    /// JSON body is also enclosed in double quotes, then you must escape the double
    /// quotes that are
    /// inside the policy:
    ///
    /// `"{\"attribute\": \"value\", \"attribute\": [\"value\"]}"`
    ///
    /// To avoid escaping quotes, you can use single quotes to enclose the policy
    /// and double
    /// quotes to enclose the JSON names and values:
    ///
    /// `'{"attribute": "value", "attribute": ["value"]}'`
    model_policy: ?[]const u8 = null,

    /// Specifies the location for the output files from a custom classifier job.
    /// This parameter is required for a request that creates a native document
    /// model.
    output_data_config: ?DocumentClassifierOutputDataConfig = null,

    /// Tags to associate with the document classifier. A tag is a key-value
    /// pair that adds as a metadata to a resource used by Amazon Comprehend. For
    /// example, a tag with
    /// "Sales" as the key might be added to a resource to indicate its use by the
    /// sales department.
    tags: ?[]const Tag = null,

    /// The version name given to the newly created classifier. Version names can
    /// have a maximum
    /// of 256 characters. Alphanumeric characters, hyphens (-) and underscores (_)
    /// are allowed. The
    /// version name must be unique among all models with the same classifier name
    /// in the Amazon Web Services account/Amazon Web Services Region.
    version_name: ?[]const u8 = null,

    /// ID for the Amazon Web Services Key Management Service (KMS) key that Amazon
    /// Comprehend uses to encrypt
    /// data on the storage volume attached to the ML compute instance(s) that
    /// process the analysis
    /// job. The VolumeKmsKeyId can be either of the following formats:
    ///
    /// * KMS Key ID: `"1234abcd-12ab-34cd-56ef-1234567890ab"`
    ///
    /// * Amazon Resource Name (ARN) of a KMS Key:
    /// `"arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab"`
    volume_kms_key_id: ?[]const u8 = null,

    /// Configuration parameters for an optional private Virtual Private Cloud (VPC)
    /// containing
    /// the resources you are using for your custom classifier. For more
    /// information, see [Amazon
    /// VPC](https://docs.aws.amazon.com/vpc/latest/userguide/what-is-amazon-vpc.html).
    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .data_access_role_arn = "DataAccessRoleArn",
        .document_classifier_name = "DocumentClassifierName",
        .input_data_config = "InputDataConfig",
        .language_code = "LanguageCode",
        .mode = "Mode",
        .model_kms_key_id = "ModelKmsKeyId",
        .model_policy = "ModelPolicy",
        .output_data_config = "OutputDataConfig",
        .tags = "Tags",
        .version_name = "VersionName",
        .volume_kms_key_id = "VolumeKmsKeyId",
        .vpc_config = "VpcConfig",
    };
};

pub const CreateDocumentClassifierOutput = struct {
    /// The Amazon Resource Name (ARN) that identifies the document classifier.
    document_classifier_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .document_classifier_arn = "DocumentClassifierArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDocumentClassifierInput, options: CallOptions) !CreateDocumentClassifierOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDocumentClassifierInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Comprehend_20171127.CreateDocumentClassifier");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDocumentClassifierOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateDocumentClassifierOutput, body, allocator);
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
