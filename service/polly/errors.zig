const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        engine_not_supported_exception: EngineNotSupportedException,
        invalid_lexicon_exception: InvalidLexiconException,
        invalid_next_token_exception: InvalidNextTokenException,
        invalid_s3_bucket_exception: InvalidS3BucketException,
        invalid_s3_key_exception: InvalidS3KeyException,
        invalid_sample_rate_exception: InvalidSampleRateException,
        invalid_sns_topic_arn_exception: InvalidSnsTopicArnException,
        invalid_ssml_exception: InvalidSsmlException,
        invalid_task_id_exception: InvalidTaskIdException,
        language_not_supported_exception: LanguageNotSupportedException,
        lexicon_not_found_exception: LexiconNotFoundException,
        lexicon_size_exceeded_exception: LexiconSizeExceededException,
        marks_not_supported_for_format_exception: MarksNotSupportedForFormatException,
        max_lexeme_length_exceeded_exception: MaxLexemeLengthExceededException,
        max_lexicons_number_exceeded_exception: MaxLexiconsNumberExceededException,
        service_failure_exception: ServiceFailureException,
        service_quota_exceeded_exception: ServiceQuotaExceededException,
        ssml_marks_not_supported_for_text_type_exception: SsmlMarksNotSupportedForTextTypeException,
        synthesis_task_not_found_exception: SynthesisTaskNotFoundException,
        text_length_exceeded_exception: TextLengthExceededException,
        throttling_exception: ThrottlingException,
        unsupported_pls_alphabet_exception: UnsupportedPlsAlphabetException,
        unsupported_pls_language_exception: UnsupportedPlsLanguageException,
        validation_exception: ValidationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .engine_not_supported_exception => "EngineNotSupportedException",
                .invalid_lexicon_exception => "InvalidLexiconException",
                .invalid_next_token_exception => "InvalidNextTokenException",
                .invalid_s3_bucket_exception => "InvalidS3BucketException",
                .invalid_s3_key_exception => "InvalidS3KeyException",
                .invalid_sample_rate_exception => "InvalidSampleRateException",
                .invalid_sns_topic_arn_exception => "InvalidSnsTopicArnException",
                .invalid_ssml_exception => "InvalidSsmlException",
                .invalid_task_id_exception => "InvalidTaskIdException",
                .language_not_supported_exception => "LanguageNotSupportedException",
                .lexicon_not_found_exception => "LexiconNotFoundException",
                .lexicon_size_exceeded_exception => "LexiconSizeExceededException",
                .marks_not_supported_for_format_exception => "MarksNotSupportedForFormatException",
                .max_lexeme_length_exceeded_exception => "MaxLexemeLengthExceededException",
                .max_lexicons_number_exceeded_exception => "MaxLexiconsNumberExceededException",
                .service_failure_exception => "ServiceFailureException",
                .service_quota_exceeded_exception => "ServiceQuotaExceededException",
                .ssml_marks_not_supported_for_text_type_exception => "SsmlMarksNotSupportedForTextTypeException",
                .synthesis_task_not_found_exception => "SynthesisTaskNotFoundException",
                .text_length_exceeded_exception => "TextLengthExceededException",
                .throttling_exception => "ThrottlingException",
                .unsupported_pls_alphabet_exception => "UnsupportedPlsAlphabetException",
                .unsupported_pls_language_exception => "UnsupportedPlsLanguageException",
                .validation_exception => "ValidationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .engine_not_supported_exception => |e| e.message,
                .invalid_lexicon_exception => |e| e.message,
                .invalid_next_token_exception => |e| e.message,
                .invalid_s3_bucket_exception => |e| e.message,
                .invalid_s3_key_exception => |e| e.message,
                .invalid_sample_rate_exception => |e| e.message,
                .invalid_sns_topic_arn_exception => |e| e.message,
                .invalid_ssml_exception => |e| e.message,
                .invalid_task_id_exception => |e| e.message,
                .language_not_supported_exception => |e| e.message,
                .lexicon_not_found_exception => |e| e.message,
                .lexicon_size_exceeded_exception => |e| e.message,
                .marks_not_supported_for_format_exception => |e| e.message,
                .max_lexeme_length_exceeded_exception => |e| e.message,
                .max_lexicons_number_exceeded_exception => |e| e.message,
                .service_failure_exception => |e| e.message,
                .service_quota_exceeded_exception => |e| e.message,
                .ssml_marks_not_supported_for_text_type_exception => |e| e.message,
                .synthesis_task_not_found_exception => |e| e.message,
                .text_length_exceeded_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .unsupported_pls_alphabet_exception => |e| e.message,
                .unsupported_pls_language_exception => |e| e.message,
                .validation_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .engine_not_supported_exception => 400,
                .invalid_lexicon_exception => 400,
                .invalid_next_token_exception => 400,
                .invalid_s3_bucket_exception => 400,
                .invalid_s3_key_exception => 400,
                .invalid_sample_rate_exception => 400,
                .invalid_sns_topic_arn_exception => 400,
                .invalid_ssml_exception => 400,
                .invalid_task_id_exception => 400,
                .language_not_supported_exception => 400,
                .lexicon_not_found_exception => 404,
                .lexicon_size_exceeded_exception => 400,
                .marks_not_supported_for_format_exception => 400,
                .max_lexeme_length_exceeded_exception => 400,
                .max_lexicons_number_exceeded_exception => 400,
                .service_failure_exception => 500,
                .service_quota_exceeded_exception => 402,
                .ssml_marks_not_supported_for_text_type_exception => 400,
                .synthesis_task_not_found_exception => 400,
                .text_length_exceeded_exception => 400,
                .throttling_exception => 400,
                .unsupported_pls_alphabet_exception => 400,
                .unsupported_pls_language_exception => 400,
                .validation_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .engine_not_supported_exception => |e| e.request_id,
                .invalid_lexicon_exception => |e| e.request_id,
                .invalid_next_token_exception => |e| e.request_id,
                .invalid_s3_bucket_exception => |e| e.request_id,
                .invalid_s3_key_exception => |e| e.request_id,
                .invalid_sample_rate_exception => |e| e.request_id,
                .invalid_sns_topic_arn_exception => |e| e.request_id,
                .invalid_ssml_exception => |e| e.request_id,
                .invalid_task_id_exception => |e| e.request_id,
                .language_not_supported_exception => |e| e.request_id,
                .lexicon_not_found_exception => |e| e.request_id,
                .lexicon_size_exceeded_exception => |e| e.request_id,
                .marks_not_supported_for_format_exception => |e| e.request_id,
                .max_lexeme_length_exceeded_exception => |e| e.request_id,
                .max_lexicons_number_exceeded_exception => |e| e.request_id,
                .service_failure_exception => |e| e.request_id,
                .service_quota_exceeded_exception => |e| e.request_id,
                .ssml_marks_not_supported_for_text_type_exception => |e| e.request_id,
                .synthesis_task_not_found_exception => |e| e.request_id,
                .text_length_exceeded_exception => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
                .unsupported_pls_alphabet_exception => |e| e.request_id,
                .unsupported_pls_language_exception => |e| e.request_id,
                .validation_exception => |e| e.request_id,
                .unknown => |e| e.request_id,
            };
        }
    };

    pub fn deinit(self: *ServiceError) void {
        if (self.arena) |*a| a.deinit();
    }

    pub fn code(self: ServiceError) []const u8 {
        return self.kind.code();
    }

    pub fn message(self: ServiceError) []const u8 {
        return self.kind.message();
    }

    pub fn httpStatus(self: ServiceError) u16 {
        return self.kind.httpStatus();
    }

    pub fn requestId(self: ServiceError) []const u8 {
        return self.kind.requestId();
    }
};

pub const EngineNotSupportedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidLexiconException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidNextTokenException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidS3BucketException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidS3KeyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidSampleRateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidSnsTopicArnException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidSsmlException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidTaskIdException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LanguageNotSupportedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LexiconNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LexiconSizeExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MarksNotSupportedForFormatException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MaxLexemeLengthExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MaxLexiconsNumberExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceFailureException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ServiceQuotaExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SsmlMarksNotSupportedForTextTypeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SynthesisTaskNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TextLengthExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedPlsAlphabetException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedPlsLanguageException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};

/// Parse a service diagnostic. The caller must call deinit on the result.
pub fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) std.mem.Allocator.Error!ServiceError {
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

    if (std.mem.eql(u8, error_code, "EngineNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .engine_not_supported_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidLexiconException")) {
        return .{ .arena = arena, .kind = .{ .invalid_lexicon_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidS3BucketException")) {
        return .{ .arena = arena, .kind = .{ .invalid_s3_bucket_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidS3KeyException")) {
        return .{ .arena = arena, .kind = .{ .invalid_s3_key_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSampleRateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_sample_rate_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSnsTopicArnException")) {
        return .{ .arena = arena, .kind = .{ .invalid_sns_topic_arn_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSsmlException")) {
        return .{ .arena = arena, .kind = .{ .invalid_ssml_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTaskIdException")) {
        return .{ .arena = arena, .kind = .{ .invalid_task_id_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LanguageNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .language_not_supported_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LexiconNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .lexicon_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LexiconSizeExceededException")) {
        return .{ .arena = arena, .kind = .{ .lexicon_size_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MarksNotSupportedForFormatException")) {
        return .{ .arena = arena, .kind = .{ .marks_not_supported_for_format_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MaxLexemeLengthExceededException")) {
        return .{ .arena = arena, .kind = .{ .max_lexeme_length_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MaxLexiconsNumberExceededException")) {
        return .{ .arena = arena, .kind = .{ .max_lexicons_number_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceFailureException")) {
        return .{ .arena = arena, .kind = .{ .service_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SsmlMarksNotSupportedForTextTypeException")) {
        return .{ .arena = arena, .kind = .{ .ssml_marks_not_supported_for_text_type_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SynthesisTaskNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .synthesis_task_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TextLengthExceededException")) {
        return .{ .arena = arena, .kind = .{ .text_length_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedPlsAlphabetException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_pls_alphabet_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedPlsLanguageException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_pls_language_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
