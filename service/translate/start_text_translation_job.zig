const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const InputDataConfig = @import("input_data_config.zig").InputDataConfig;
const OutputDataConfig = @import("output_data_config.zig").OutputDataConfig;
const TranslationSettings = @import("translation_settings.zig").TranslationSettings;
const JobStatus = @import("job_status.zig").JobStatus;

pub const StartTextTranslationJobInput = struct {
    /// A unique identifier for the request. This token is generated for you when
    /// using the Amazon Translate
    /// SDK.
    client_token: []const u8,

    /// The Amazon Resource Name (ARN) of an AWS Identity Access and Management
    /// (IAM) role
    /// that grants Amazon Translate read access to your input data. For more
    /// information, see
    /// [Identity and access management
    /// ](https://docs.aws.amazon.com/translate/latest/dg/identity-and-access-management.html).
    data_access_role_arn: []const u8,

    /// Specifies the format and location of the input documents for the translation
    /// job.
    input_data_config: InputDataConfig,

    /// The name of the batch translation job to be performed.
    job_name: ?[]const u8 = null,

    /// Specifies the S3 folder to which your job output will be saved.
    output_data_config: OutputDataConfig,

    /// The name of a parallel data resource to add to the translation job. This
    /// resource consists
    /// of examples that show how you want segments of text to be translated.
    /// If you specify multiple target languages for
    /// the job, the parallel data file must include translations for
    /// all the target languages.
    ///
    /// When you add parallel
    /// data to a translation job, you create an *Active Custom Translation* job.
    ///
    /// This parameter accepts only one parallel data resource.
    ///
    /// Active Custom Translation jobs are priced at a higher rate than other jobs
    /// that don't
    /// use parallel data. For more information, see [Amazon Translate
    /// pricing](http://aws.amazon.com/translate/pricing/).
    ///
    /// For a list of available parallel data resources, use the ListParallelData
    /// operation.
    ///
    /// For more information, see [
    /// Customizing your translations with parallel
    /// data](https://docs.aws.amazon.com/translate/latest/dg/customizing-translations-parallel-data.html).
    parallel_data_names: ?[]const []const u8 = null,

    /// Settings to configure your translation output. You can configure the
    /// following options:
    ///
    /// * Brevity: not supported.
    ///
    /// * Formality: sets the formality level of the output text.
    ///
    /// * Profanity: masks profane words and phrases in your translation output.
    settings: ?TranslationSettings = null,

    /// The language code of the input language. Specify the language if all input
    /// documents share the same language.
    /// If you don't know the language of the source files, or your input documents
    /// contains different source
    /// languages, select `auto`. Amazon Translate auto detects the source language
    /// for each input document.
    /// For a list of supported language codes, see
    /// [Supported
    /// languages](https://docs.aws.amazon.com/translate/latest/dg/what-is-languages.html).
    source_language_code: []const u8,

    /// The target languages of the translation job. Enter up to 10 language codes.
    /// Each input file is translated into each target language.
    ///
    /// Each language code is 2 or 5 characters long. For a list of language codes,
    /// see [Supported
    /// languages](https://docs.aws.amazon.com/translate/latest/dg/what-is-languages.html).
    target_language_codes: []const []const u8,

    /// The name of a custom terminology resource to add to the translation job.
    /// This resource
    /// lists examples source terms and the desired translation for each term.
    ///
    /// This parameter accepts only one custom terminology resource.
    ///
    /// If you specify multiple target languages for the
    /// job, translate uses the designated terminology for each
    /// requested target language that has an entry for the source term
    /// in the terminology file.
    ///
    /// For a list of available custom terminology resources, use the
    /// ListTerminologies operation.
    ///
    /// For more information, see [Custom
    /// terminology](https://docs.aws.amazon.com/translate/latest/dg/how-custom-terminology.html).
    terminology_names: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .data_access_role_arn = "DataAccessRoleArn",
        .input_data_config = "InputDataConfig",
        .job_name = "JobName",
        .output_data_config = "OutputDataConfig",
        .parallel_data_names = "ParallelDataNames",
        .settings = "Settings",
        .source_language_code = "SourceLanguageCode",
        .target_language_codes = "TargetLanguageCodes",
        .terminology_names = "TerminologyNames",
    };
};

pub const StartTextTranslationJobOutput = struct {
    /// The identifier generated for the job. To get the status of a job, use this
    /// ID with the
    /// DescribeTextTranslationJob operation.
    job_id: ?[]const u8 = null,

    /// The status of the job. Possible values include:
    ///
    /// * `SUBMITTED` - The job has been received and is queued for
    /// processing.
    ///
    /// * `IN_PROGRESS` - Amazon Translate is processing the job.
    ///
    /// * `COMPLETED` - The job was successfully completed and the output is
    /// available.
    ///
    /// * `COMPLETED_WITH_ERROR` - The job was completed with errors. The errors can
    /// be analyzed in the job's output.
    ///
    /// * `FAILED` - The job did not complete. To get details, use the
    ///   DescribeTextTranslationJob operation.
    ///
    /// * `STOP_REQUESTED` - The user who started the job has requested that it be
    /// stopped.
    ///
    /// * `STOPPED` - The job has been stopped.
    job_status: ?JobStatus = null,

    pub const json_field_names = .{
        .job_id = "JobId",
        .job_status = "JobStatus",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartTextTranslationJobInput, options: Options) !StartTextTranslationJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "translate");

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartTextTranslationJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("translate", "Translate", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "AWSShineFrontendService_20170701.StartTextTranslationJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartTextTranslationJobOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartTextTranslationJobOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
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
    if (std.mem.eql(u8, error_code, "DetectedLanguageLowConfidenceException")) {
        return .{ .arena = arena, .kind = .{ .detected_language_low_confidence_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_value_exception = .{
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
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
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
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedDisplayLanguageCodeException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_display_language_code_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedLanguagePairException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_language_pair_exception = .{
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
