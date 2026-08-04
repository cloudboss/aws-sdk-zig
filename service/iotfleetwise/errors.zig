const std = @import("std");

const InvalidNetworkInterface = @import("invalid_network_interface.zig").InvalidNetworkInterface;
const InvalidSignal = @import("invalid_signal.zig").InvalidSignal;
const InvalidSignalDecoder = @import("invalid_signal_decoder.zig").InvalidSignalDecoder;
const Node = @import("node.zig").Node;
const ValidationExceptionField = @import("validation_exception_field.zig").ValidationExceptionField;
const ValidationExceptionReason = @import("validation_exception_reason.zig").ValidationExceptionReason;

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        conflict_exception: ConflictException,
        decoder_manifest_validation_exception: DecoderManifestValidationException,
        internal_server_exception: InternalServerException,
        invalid_node_exception: InvalidNodeException,
        invalid_signals_exception: InvalidSignalsException,
        limit_exceeded_exception: LimitExceededException,
        resource_not_found_exception: ResourceNotFoundException,
        throttling_exception: ThrottlingException,
        validation_exception: ValidationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .conflict_exception => "ConflictException",
                .decoder_manifest_validation_exception => "DecoderManifestValidationException",
                .internal_server_exception => "InternalServerException",
                .invalid_node_exception => "InvalidNodeException",
                .invalid_signals_exception => "InvalidSignalsException",
                .limit_exceeded_exception => "LimitExceededException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .throttling_exception => "ThrottlingException",
                .validation_exception => "ValidationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .conflict_exception => |e| e.message,
                .decoder_manifest_validation_exception => |e| e.message,
                .internal_server_exception => |e| e.message,
                .invalid_node_exception => |e| e.message,
                .invalid_signals_exception => |e| e.message,
                .limit_exceeded_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .throttling_exception => |e| e.message,
                .validation_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 403,
                .conflict_exception => 409,
                .decoder_manifest_validation_exception => 400,
                .internal_server_exception => 500,
                .invalid_node_exception => 400,
                .invalid_signals_exception => 400,
                .limit_exceeded_exception => 400,
                .resource_not_found_exception => 404,
                .throttling_exception => 429,
                .validation_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .decoder_manifest_validation_exception => |e| e.request_id,
                .internal_server_exception => |e| e.request_id,
                .invalid_node_exception => |e| e.request_id,
                .invalid_signals_exception => |e| e.request_id,
                .limit_exceeded_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
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

/// You don't have sufficient permission to perform this action.
pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    pub const json_field_names = .{
        .message = "message",
    };
};

/// The request has conflicting operations. This can occur if you're trying to
/// perform
/// more than one operation on the same resource at the same time.
pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The resource on which there are conflicting operations.
    resource: []const u8,

    /// The type of resource on which there are conflicting operations..
    resource_type: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .resource = "resource",
        .resource_type = "resourceType",
    };
};

/// The request couldn't be completed because it contains signal decoders with
/// one or more
/// validation errors.
pub const DecoderManifestValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The request couldn't be completed because of invalid network interfaces in
    /// the
    /// request.
    invalid_network_interfaces: ?[]const InvalidNetworkInterface = null,

    /// The request couldn't be completed because of invalid signals in the request.
    invalid_signals: ?[]const InvalidSignalDecoder = null,

    pub const json_field_names = .{
        .invalid_network_interfaces = "invalidNetworkInterfaces",
        .invalid_signals = "invalidSignals",
        .message = "message",
    };
};

/// The request couldn't be completed because the server temporarily failed.
pub const InternalServerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The number of seconds to wait before retrying the command.
    retry_after_seconds: ?i32 = null,

    pub const json_field_names = .{
        .message = "message",
        .retry_after_seconds = "retryAfterSeconds",
    };
};

/// The specified node type doesn't match the expected node type for a node. You
/// can
/// specify the node type as branch, sensor, actuator, or attribute.
pub const InvalidNodeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The specified node type isn't valid.
    invalid_nodes: ?[]const Node = null,

    /// The reason the node validation failed.
    reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .invalid_nodes = "invalidNodes",
        .message = "message",
        .reason = "reason",
    };
};

/// The request couldn't be completed because it contains signals that aren't
/// valid.
pub const InvalidSignalsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The signals which caused the exception.
    invalid_signals: ?[]const InvalidSignal = null,

    pub const json_field_names = .{
        .invalid_signals = "invalidSignals",
        .message = "message",
    };
};

/// A service quota was exceeded.
pub const LimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The identifier of the resource that was exceeded.
    resource_id: []const u8,

    /// The type of resource that was exceeded.
    resource_type: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .resource_id = "resourceId",
        .resource_type = "resourceType",
    };
};

/// The resource wasn't found.
pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The identifier of the resource that wasn't found.
    resource_id: []const u8,

    /// The type of resource that wasn't found.
    resource_type: []const u8,

    pub const json_field_names = .{
        .message = "message",
        .resource_id = "resourceId",
        .resource_type = "resourceType",
    };
};

/// The request couldn't be completed due to throttling.
pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The quota identifier of the applied throttling rules for this request.
    quota_code: ?[]const u8 = null,

    /// The number of seconds to wait before retrying the command.
    retry_after_seconds: ?i32 = null,

    /// The code for the service that couldn't be completed due to throttling.
    service_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "message",
        .quota_code = "quotaCode",
        .retry_after_seconds = "retryAfterSeconds",
        .service_code = "serviceCode",
    };
};

/// The input fails to satisfy the constraints specified by an Amazon Web
/// Services service.
pub const ValidationException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",

    /// The list of fields that fail to satisfy the constraints specified by an
    /// Amazon Web Services
    /// service.
    field_list: ?[]const ValidationExceptionField = null,

    /// The reason the input failed to satisfy the constraints specified by an
    /// Amazon Web Services
    /// service.
    reason: ?ValidationExceptionReason = null,

    pub const json_field_names = .{
        .field_list = "fieldList",
        .message = "message",
        .reason = "reason",
    };
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
