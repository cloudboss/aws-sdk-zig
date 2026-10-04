const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        concurrent_modification_exception: ConcurrentModificationException,
        conflict_exception: ConflictException,
        detected_language_low_confidence_exception: DetectedLanguageLowConfidenceException,
        internal_server_exception: InternalServerException,
        invalid_filter_exception: InvalidFilterException,
        invalid_parameter_value_exception: InvalidParameterValueException,
        invalid_request_exception: InvalidRequestException,
        limit_exceeded_exception: LimitExceededException,
        resource_not_found_exception: ResourceNotFoundException,
        service_unavailable_exception: ServiceUnavailableException,
        text_size_limit_exceeded_exception: TextSizeLimitExceededException,
        too_many_requests_exception: TooManyRequestsException,
        too_many_tags_exception: TooManyTagsException,
        unsupported_display_language_code_exception: UnsupportedDisplayLanguageCodeException,
        unsupported_language_pair_exception: UnsupportedLanguagePairException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .concurrent_modification_exception => "ConcurrentModificationException",
                .conflict_exception => "ConflictException",
                .detected_language_low_confidence_exception => "DetectedLanguageLowConfidenceException",
                .internal_server_exception => "InternalServerException",
                .invalid_filter_exception => "InvalidFilterException",
                .invalid_parameter_value_exception => "InvalidParameterValueException",
                .invalid_request_exception => "InvalidRequestException",
                .limit_exceeded_exception => "LimitExceededException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .service_unavailable_exception => "ServiceUnavailableException",
                .text_size_limit_exceeded_exception => "TextSizeLimitExceededException",
                .too_many_requests_exception => "TooManyRequestsException",
                .too_many_tags_exception => "TooManyTagsException",
                .unsupported_display_language_code_exception => "UnsupportedDisplayLanguageCodeException",
                .unsupported_language_pair_exception => "UnsupportedLanguagePairException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .concurrent_modification_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .detected_language_low_confidence_exception => |e| e.message,
                .internal_server_exception => |e| e.message,
                .invalid_filter_exception => |e| e.message,
                .invalid_parameter_value_exception => |e| e.message,
                .invalid_request_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .service_unavailable_exception => |e| e.message,
                .text_size_limit_exceeded_exception => |e| e.message,
                .too_many_requests_exception => |e| e.message,
                .too_many_tags_exception => |e| e.message,
                .unsupported_display_language_code_exception => |e| e.message,
                .unsupported_language_pair_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .concurrent_modification_exception => 409,
                .conflict_exception => 409,
                .detected_language_low_confidence_exception => 400,
                .internal_server_exception => 500,
                .invalid_filter_exception => 400,
                .invalid_parameter_value_exception => 400,
                .invalid_request_exception => 400,
                .limit_exceeded_exception => 400,
                .resource_not_found_exception => 404,
                .service_unavailable_exception => 503,
                .text_size_limit_exceeded_exception => 400,
                .too_many_requests_exception => 429,
                .too_many_tags_exception => 400,
                .unsupported_display_language_code_exception => 400,
                .unsupported_language_pair_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .concurrent_modification_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .detected_language_low_confidence_exception => |e| e.request_id,
                .internal_server_exception => |e| e.request_id,
                .invalid_filter_exception => |e| e.request_id,
                .invalid_parameter_value_exception => |e| e.request_id,
                .invalid_request_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .service_unavailable_exception => |e| e.request_id,
                .text_size_limit_exceeded_exception => |e| e.request_id,
                .too_many_requests_exception => |e| e.request_id,
                .too_many_tags_exception => |e| e.request_id,
                .unsupported_display_language_code_exception => |e| e.request_id,
                .unsupported_language_pair_exception => |e| e.request_id,
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

/// Another modification is being made. That modification must complete before
/// you can make
/// your change.
pub const ConcurrentModificationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// There was a conflict processing the request. Try your request again.
pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The confidence that Amazon Comprehend accurately detected the source
/// language is low. If a
/// low confidence level is acceptable for your application, you can use the
/// language in the
/// exception to call Amazon Translate again. For more information, see the
/// [DetectDominantLanguage](https://docs.aws.amazon.com/comprehend/latest/dg/API_DetectDominantLanguage.html) operation in the *Amazon Comprehend Developer
/// Guide*.
pub const DetectedLanguageLowConfidenceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The language code of the auto-detected language from Amazon Comprehend.
    detected_language_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .detected_language_code = "DetectedLanguageCode",
        .message = "Message",
    };
};

/// An internal server error occurred. Retry your request.
pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The filter specified for the operation is not valid. Specify a different
/// filter.
pub const InvalidFilterException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The value of the parameter is not valid. Review the value of the parameter
/// you are using
/// to correct it, and then retry your operation.
pub const InvalidParameterValueException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request that you made is not valid. Check your request to determine why
/// it's not
/// valid and then retry the request.
pub const InvalidRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified limit has been exceeded. Review your request and retry it with
/// a quantity
/// below the stated limit.
pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The resource you are looking for has not been found. Review the resource
/// you're looking
/// for and see if a different resource will accomplish your needs before
/// retrying the revised
/// request.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The Amazon Translate service is temporarily unavailable. Wait a bit and then
/// retry your
/// request.
pub const ServiceUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The size of the text you submitted exceeds the size limit. Reduce the size
/// of the text or
/// use a smaller document and then retry your request.
pub const TextSizeLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You have made too many requests within a short period of time. Wait for a
/// short time and
/// then try your request again.
pub const TooManyRequestsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// You have added too many tags to this resource. The maximum is 50 tags.
pub const TooManyTagsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    resource_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "message",
        .resource_arn = "ResourceArn",
    };
};

/// Requested display language code is not supported.
pub const UnsupportedDisplayLanguageCodeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// Language code passed in with the request.
    display_language_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .display_language_code = "DisplayLanguageCode",
        .message = "Message",
    };
};

/// Amazon Translate does not support translation from the language of the
/// source text into the requested
/// target language. For more information, see [Supported
/// languages](https://docs.aws.amazon.com/translate/latest/dg/what-is-languages.html).
pub const UnsupportedLanguagePairException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The language code for the language of the input text.
    source_language_code: ?[]const u8 = null,

    /// The language code for the language of the translated text.
    target_language_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
        .source_language_code = "SourceLanguageCode",
        .target_language_code = "TargetLanguageCode",
    };
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

    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        const parsed_error: ?ConcurrentModificationException = aws.json.parseJsonObject(ConcurrentModificationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        const parsed_error: ?ConflictException = aws.json.parseJsonObject(ConflictException, body, arena_alloc) catch |err| switch (err) {
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
    if (std.mem.eql(u8, error_code, "DetectedLanguageLowConfidenceException")) {
        const parsed_error: ?DetectedLanguageLowConfidenceException = aws.json.parseJsonObject(DetectedLanguageLowConfidenceException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .detected_language_low_confidence_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        const parsed_error: ?InternalServerException = aws.json.parseJsonObject(InternalServerException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_server_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidFilterException")) {
        const parsed_error: ?InvalidFilterException = aws.json.parseJsonObject(InvalidFilterException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_filter_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        const parsed_error: ?InvalidParameterValueException = aws.json.parseJsonObject(InvalidParameterValueException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_parameter_value_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        const parsed_error: ?InvalidRequestException = aws.json.parseJsonObject(InvalidRequestException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_request_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        const parsed_error: ?LimitExceededException = aws.json.parseJsonObject(LimitExceededException, body, arena_alloc) catch |err| switch (err) {
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
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        const parsed_error: ?ResourceNotFoundException = aws.json.parseJsonObject(ResourceNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        const parsed_error: ?ServiceUnavailableException = aws.json.parseJsonObject(ServiceUnavailableException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_unavailable_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TextSizeLimitExceededException")) {
        const parsed_error: ?TextSizeLimitExceededException = aws.json.parseJsonObject(TextSizeLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .text_size_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        const parsed_error: ?TooManyRequestsException = aws.json.parseJsonObject(TooManyRequestsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .too_many_requests_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        const parsed_error: ?TooManyTagsException = aws.json.parseJsonObject(TooManyTagsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .too_many_tags_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedDisplayLanguageCodeException")) {
        const parsed_error: ?UnsupportedDisplayLanguageCodeException = aws.json.parseJsonObject(UnsupportedDisplayLanguageCodeException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_display_language_code_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedLanguagePairException")) {
        const parsed_error: ?UnsupportedLanguagePairException = aws.json.parseJsonObject(UnsupportedLanguagePairException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_language_pair_exception = typed_error } };
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
