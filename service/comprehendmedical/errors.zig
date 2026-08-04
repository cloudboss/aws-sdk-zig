const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        internal_server_exception: InternalServerException,
        invalid_encoding_exception: InvalidEncodingException,
        invalid_request_exception: InvalidRequestException,
        resource_not_found_exception: ResourceNotFoundException,
        service_unavailable_exception: ServiceUnavailableException,
        text_size_limit_exceeded_exception: TextSizeLimitExceededException,
        too_many_requests_exception: TooManyRequestsException,
        validation_exception: ValidationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .internal_server_exception => "InternalServerException",
                .invalid_encoding_exception => "InvalidEncodingException",
                .invalid_request_exception => "InvalidRequestException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .service_unavailable_exception => "ServiceUnavailableException",
                .text_size_limit_exceeded_exception => "TextSizeLimitExceededException",
                .too_many_requests_exception => "TooManyRequestsException",
                .validation_exception => "ValidationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .internal_server_exception => |e| e.message,
                .invalid_encoding_exception => |e| e.message,
                .invalid_request_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .service_unavailable_exception => |e| e.message,
                .text_size_limit_exceeded_exception => |e| e.message,
                .too_many_requests_exception => |e| e.message,
                .validation_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .internal_server_exception => 500,
                .invalid_encoding_exception => 400,
                .invalid_request_exception => 400,
                .resource_not_found_exception => 404,
                .service_unavailable_exception => 503,
                .text_size_limit_exceeded_exception => 400,
                .too_many_requests_exception => 429,
                .validation_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .internal_server_exception => |e| e.request_id,
                .invalid_encoding_exception => |e| e.request_id,
                .invalid_request_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .service_unavailable_exception => |e| e.request_id,
                .text_size_limit_exceeded_exception => |e| e.request_id,
                .too_many_requests_exception => |e| e.request_id,
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

/// An internal server error occurred. Retry your request.
pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The input text was not in valid UTF-8 character encoding. Check your text
/// then retry your
/// request.
pub const InvalidEncodingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request that you made is invalid. Check your request to determine why
/// it's invalid
/// and then retry the request.
pub const InvalidRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The resource identified by the specified Amazon Resource Name (ARN) was not
/// found. Check
/// the ARN and try your request again.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The Amazon Comprehend Medical service is temporarily unavailable. Please
/// wait and then retry your request.
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
/// then try your request again. Contact customer support for more information
/// about a service
/// limit increase.
pub const TooManyRequestsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The filter that you specified for the operation is invalid. Check the filter
/// values that
/// you entered and try your request again.
pub const ValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
