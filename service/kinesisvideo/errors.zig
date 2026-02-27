const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_denied_exception: AccessDeniedException,
        account_channel_limit_exceeded_exception: AccountChannelLimitExceededException,
        account_stream_limit_exceeded_exception: AccountStreamLimitExceededException,
        client_limit_exceeded_exception: ClientLimitExceededException,
        device_stream_limit_exceeded_exception: DeviceStreamLimitExceededException,
        invalid_argument_exception: InvalidArgumentException,
        invalid_device_exception: InvalidDeviceException,
        invalid_resource_format_exception: InvalidResourceFormatException,
        no_data_retention_exception: NoDataRetentionException,
        not_authorized_exception: NotAuthorizedException,
        resource_in_use_exception: ResourceInUseException,
        resource_not_found_exception: ResourceNotFoundException,
        stream_edge_configuration_not_found_exception: StreamEdgeConfigurationNotFoundException,
        tags_per_resource_exceeded_limit_exception: TagsPerResourceExceededLimitException,
        version_mismatch_exception: VersionMismatchException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => "AccessDeniedException",
                .account_channel_limit_exceeded_exception => "AccountChannelLimitExceededException",
                .account_stream_limit_exceeded_exception => "AccountStreamLimitExceededException",
                .client_limit_exceeded_exception => "ClientLimitExceededException",
                .device_stream_limit_exceeded_exception => "DeviceStreamLimitExceededException",
                .invalid_argument_exception => "InvalidArgumentException",
                .invalid_device_exception => "InvalidDeviceException",
                .invalid_resource_format_exception => "InvalidResourceFormatException",
                .no_data_retention_exception => "NoDataRetentionException",
                .not_authorized_exception => "NotAuthorizedException",
                .resource_in_use_exception => "ResourceInUseException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .stream_edge_configuration_not_found_exception => "StreamEdgeConfigurationNotFoundException",
                .tags_per_resource_exceeded_limit_exception => "TagsPerResourceExceededLimitException",
                .version_mismatch_exception => "VersionMismatchException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.message,
                .account_channel_limit_exceeded_exception => |e| e.message,
                .account_stream_limit_exceeded_exception => |e| e.message,
                .client_limit_exceeded_exception => |e| e.message,
                .device_stream_limit_exceeded_exception => |e| e.message,
                .invalid_argument_exception => |e| e.message,
                .invalid_device_exception => |e| e.message,
                .invalid_resource_format_exception => |e| e.message,
                .no_data_retention_exception => |e| e.message,
                .not_authorized_exception => |e| e.message,
                .resource_in_use_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .stream_edge_configuration_not_found_exception => |e| e.message,
                .tags_per_resource_exceeded_limit_exception => |e| e.message,
                .version_mismatch_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_denied_exception => 401,
                .account_channel_limit_exceeded_exception => 400,
                .account_stream_limit_exceeded_exception => 400,
                .client_limit_exceeded_exception => 400,
                .device_stream_limit_exceeded_exception => 400,
                .invalid_argument_exception => 400,
                .invalid_device_exception => 400,
                .invalid_resource_format_exception => 400,
                .no_data_retention_exception => 400,
                .not_authorized_exception => 401,
                .resource_in_use_exception => 400,
                .resource_not_found_exception => 404,
                .stream_edge_configuration_not_found_exception => 404,
                .tags_per_resource_exceeded_limit_exception => 400,
                .version_mismatch_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_denied_exception => |e| e.request_id,
                .account_channel_limit_exceeded_exception => |e| e.request_id,
                .account_stream_limit_exceeded_exception => |e| e.request_id,
                .client_limit_exceeded_exception => |e| e.request_id,
                .device_stream_limit_exceeded_exception => |e| e.request_id,
                .invalid_argument_exception => |e| e.request_id,
                .invalid_device_exception => |e| e.request_id,
                .invalid_resource_format_exception => |e| e.request_id,
                .no_data_retention_exception => |e| e.request_id,
                .not_authorized_exception => |e| e.request_id,
                .resource_in_use_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .stream_edge_configuration_not_found_exception => |e| e.request_id,
                .tags_per_resource_exceeded_limit_exception => |e| e.request_id,
                .version_mismatch_exception => |e| e.request_id,
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

pub const AccessDeniedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AccountChannelLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AccountStreamLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ClientLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DeviceStreamLimitExceededException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidArgumentException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidDeviceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidResourceFormatException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoDataRetentionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NotAuthorizedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceInUseException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const StreamEdgeConfigurationNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TagsPerResourceExceededLimitException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const VersionMismatchException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnknownServiceError = struct {
    code: []const u8 = "",
    message: []const u8 = "",
    request_id: []const u8 = "",
    http_status: u16 = 0,
};
