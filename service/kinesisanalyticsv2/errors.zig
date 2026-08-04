const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        code_validation_exception: CodeValidationException,
        concurrent_modification_exception: ConcurrentModificationException,
        invalid_application_configuration_exception: InvalidApplicationConfigurationException,
        invalid_argument_exception: InvalidArgumentException,
        invalid_request_exception: InvalidRequestException,
        limit_exceeded_exception: LimitExceededException,
        resource_in_use_exception: ResourceInUseException,
        resource_not_found_exception: ResourceNotFoundException,
        resource_provisioned_throughput_exceeded_exception: ResourceProvisionedThroughputExceededException,
        service_unavailable_exception: ServiceUnavailableException,
        too_many_tags_exception: TooManyTagsException,
        unable_to_detect_schema_exception: UnableToDetectSchemaException,
        unsupported_operation_exception: UnsupportedOperationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .code_validation_exception => "CodeValidationException",
                .concurrent_modification_exception => "ConcurrentModificationException",
                .invalid_application_configuration_exception => "InvalidApplicationConfigurationException",
                .invalid_argument_exception => "InvalidArgumentException",
                .invalid_request_exception => "InvalidRequestException",
                .limit_exceeded_exception => "LimitExceededException",
                .resource_in_use_exception => "ResourceInUseException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .resource_provisioned_throughput_exceeded_exception => "ResourceProvisionedThroughputExceededException",
                .service_unavailable_exception => "ServiceUnavailableException",
                .too_many_tags_exception => "TooManyTagsException",
                .unable_to_detect_schema_exception => "UnableToDetectSchemaException",
                .unsupported_operation_exception => "UnsupportedOperationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .code_validation_exception => |e| e.message,
                .concurrent_modification_exception => |e| e.message,
                .invalid_application_configuration_exception => |e| e.message,
                .invalid_argument_exception => |e| e.message,
                .invalid_request_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .resource_in_use_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .resource_provisioned_throughput_exceeded_exception => |e| e.message,
                .service_unavailable_exception => |e| e.message,
                .too_many_tags_exception => |e| e.message,
                .unable_to_detect_schema_exception => |e| e.message,
                .unsupported_operation_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .code_validation_exception => 400,
                .concurrent_modification_exception => 409,
                .invalid_application_configuration_exception => 400,
                .invalid_argument_exception => 400,
                .invalid_request_exception => 400,
                .limit_exceeded_exception => 400,
                .resource_in_use_exception => 400,
                .resource_not_found_exception => 400,
                .resource_provisioned_throughput_exceeded_exception => 400,
                .service_unavailable_exception => 503,
                .too_many_tags_exception => 400,
                .unable_to_detect_schema_exception => 400,
                .unsupported_operation_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .code_validation_exception => |e| e.request_id,
                .concurrent_modification_exception => |e| e.request_id,
                .invalid_application_configuration_exception => |e| e.request_id,
                .invalid_argument_exception => |e| e.request_id,
                .invalid_request_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .resource_in_use_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .resource_provisioned_throughput_exceeded_exception => |e| e.request_id,
                .service_unavailable_exception => |e| e.request_id,
                .too_many_tags_exception => |e| e.request_id,
                .unable_to_detect_schema_exception => |e| e.request_id,
                .unsupported_operation_exception => |e| e.request_id,
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

/// The user-provided application code (query) is not valid. This can be a
/// simple syntax
/// error.
pub const CodeValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Exception thrown as a result of concurrent modifications to an application.
/// This error can
/// be the result of attempting to modify an application without using the
/// current application
/// ID.
pub const ConcurrentModificationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The user-provided application configuration is not valid.
pub const InvalidApplicationConfigurationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The specified input parameter value is not valid.
pub const InvalidArgumentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The request JSON is not valid for the operation.
pub const InvalidRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The number of allowed resources has been exceeded.
pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The application is not available for this operation.
pub const ResourceInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Specified application can't be found.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Discovery failed to get a record from the streaming source because of the
/// Kinesis
/// Streams `ProvisionedThroughputExceededException`. For more information, see
/// [GetRecords](http://docs.aws.amazon.com/kinesis/latest/APIReference/API_GetRecords.html) in the Amazon Kinesis Streams API Reference.
pub const ResourceProvisionedThroughputExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// The service cannot complete the request.
pub const ServiceUnavailableException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "Message",
    };
};

/// Application created with too many tags, or too many tags added to an
/// application. Note that the maximum
/// number of application tags includes system tags. The maximum number of
/// user-defined application tags is 50.
pub const TooManyTagsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The data format is not valid. Kinesis Data Analytics cannot detect the
/// schema for
/// the given streaming source.
pub const UnableToDetectSchemaException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// Stream data that was modified by the processor specified in the
    /// `InputProcessingConfiguration` parameter.
    processed_input_records: ?[]const []const u8 = null,

    /// Raw stream data that was sampled to infer the schema.
    raw_input_records: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
        .processed_input_records = "ProcessedInputRecords",
        .raw_input_records = "RawInputRecords",
    };
};

/// The request was rejected because a specified parameter is not supported or a
/// specified resource is not valid for this
/// operation.
pub const UnsupportedOperationException = struct {
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
