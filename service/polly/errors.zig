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
        ssml_marks_not_supported_for_text_type_exception: SsmlMarksNotSupportedForTextTypeException,
        synthesis_task_not_found_exception: SynthesisTaskNotFoundException,
        text_length_exceeded_exception: TextLengthExceededException,
        unsupported_pls_alphabet_exception: UnsupportedPlsAlphabetException,
        unsupported_pls_language_exception: UnsupportedPlsLanguageException,
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
                .ssml_marks_not_supported_for_text_type_exception => "SsmlMarksNotSupportedForTextTypeException",
                .synthesis_task_not_found_exception => "SynthesisTaskNotFoundException",
                .text_length_exceeded_exception => "TextLengthExceededException",
                .unsupported_pls_alphabet_exception => "UnsupportedPlsAlphabetException",
                .unsupported_pls_language_exception => "UnsupportedPlsLanguageException",
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
                .ssml_marks_not_supported_for_text_type_exception => |e| e.message,
                .synthesis_task_not_found_exception => |e| e.message,
                .text_length_exceeded_exception => |e| e.message,
                .unsupported_pls_alphabet_exception => |e| e.message,
                .unsupported_pls_language_exception => |e| e.message,
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
                .ssml_marks_not_supported_for_text_type_exception => 400,
                .synthesis_task_not_found_exception => 400,
                .text_length_exceeded_exception => 400,
                .unsupported_pls_alphabet_exception => 400,
                .unsupported_pls_language_exception => 400,
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
                .ssml_marks_not_supported_for_text_type_exception => |e| e.request_id,
                .synthesis_task_not_found_exception => |e| e.request_id,
                .text_length_exceeded_exception => |e| e.request_id,
                .unsupported_pls_alphabet_exception => |e| e.request_id,
                .unsupported_pls_language_exception => |e| e.request_id,
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

pub const UnsupportedPlsAlphabetException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedPlsLanguageException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
