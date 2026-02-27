const AccessDeniedException = @import("errors.zig").AccessDeniedException;
const ConflictException = @import("errors.zig").ConflictException;
const InternalServerException = @import("errors.zig").InternalServerException;
const ResourceNotFoundException = @import("errors.zig").ResourceNotFoundException;
const CodeInterpreterResult = @import("code_interpreter_result.zig").CodeInterpreterResult;
const ServiceQuotaExceededException = @import("errors.zig").ServiceQuotaExceededException;
const ThrottlingException = @import("errors.zig").ThrottlingException;
const ValidationException = @import("errors.zig").ValidationException;

/// Contains output from a code interpreter stream.
pub const CodeInterpreterStreamOutput = union(enum) {
    access_denied_exception: ?AccessDeniedException,
    conflict_exception: ?ConflictException,
    internal_server_exception: ?InternalServerException,
    resource_not_found_exception: ?ResourceNotFoundException,
    result: ?CodeInterpreterResult,
    service_quota_exceeded_exception: ?ServiceQuotaExceededException,
    throttling_exception: ?ThrottlingException,
    validation_exception: ?ValidationException,

    pub const json_field_names = .{
        .access_denied_exception = "accessDeniedException",
        .conflict_exception = "conflictException",
        .internal_server_exception = "internalServerException",
        .resource_not_found_exception = "resourceNotFoundException",
        .result = "result",
        .service_quota_exceeded_exception = "serviceQuotaExceededException",
        .throttling_exception = "throttlingException",
        .validation_exception = "validationException",
    };
};
