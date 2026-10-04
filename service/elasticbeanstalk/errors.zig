const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        code_build_not_in_service_region_exception: CodeBuildNotInServiceRegionException,
        elastic_beanstalk_service_exception: ElasticBeanstalkServiceException,
        insufficient_privileges_exception: InsufficientPrivilegesException,
        invalid_request_exception: InvalidRequestException,
        managed_action_invalid_state_exception: ManagedActionInvalidStateException,
        operation_in_progress_exception: OperationInProgressException,
        platform_version_still_referenced_exception: PlatformVersionStillReferencedException,
        resource_not_found_exception: ResourceNotFoundException,
        resource_type_not_supported_exception: ResourceTypeNotSupportedException,
        s3_location_not_in_service_region_exception: S3LocationNotInServiceRegionException,
        s3_subscription_required_exception: S3SubscriptionRequiredException,
        source_bundle_deletion_exception: SourceBundleDeletionException,
        too_many_application_versions_exception: TooManyApplicationVersionsException,
        too_many_applications_exception: TooManyApplicationsException,
        too_many_buckets_exception: TooManyBucketsException,
        too_many_configuration_templates_exception: TooManyConfigurationTemplatesException,
        too_many_environments_exception: TooManyEnvironmentsException,
        too_many_platforms_exception: TooManyPlatformsException,
        too_many_tags_exception: TooManyTagsException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .code_build_not_in_service_region_exception => "CodeBuildNotInServiceRegionException",
                .elastic_beanstalk_service_exception => "ElasticBeanstalkServiceException",
                .insufficient_privileges_exception => "InsufficientPrivilegesException",
                .invalid_request_exception => "InvalidRequestException",
                .managed_action_invalid_state_exception => "ManagedActionInvalidStateException",
                .operation_in_progress_exception => "OperationInProgressException",
                .platform_version_still_referenced_exception => "PlatformVersionStillReferencedException",
                .resource_not_found_exception => "ResourceNotFoundException",
                .resource_type_not_supported_exception => "ResourceTypeNotSupportedException",
                .s3_location_not_in_service_region_exception => "S3LocationNotInServiceRegionException",
                .s3_subscription_required_exception => "S3SubscriptionRequiredException",
                .source_bundle_deletion_exception => "SourceBundleDeletionException",
                .too_many_application_versions_exception => "TooManyApplicationVersionsException",
                .too_many_applications_exception => "TooManyApplicationsException",
                .too_many_buckets_exception => "TooManyBucketsException",
                .too_many_configuration_templates_exception => "TooManyConfigurationTemplatesException",
                .too_many_environments_exception => "TooManyEnvironmentsException",
                .too_many_platforms_exception => "TooManyPlatformsException",
                .too_many_tags_exception => "TooManyTagsException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .code_build_not_in_service_region_exception => |e| e.message,
                .elastic_beanstalk_service_exception => |e| e.message,
                .insufficient_privileges_exception => |e| e.message,
                .invalid_request_exception => |e| e.message,
                .managed_action_invalid_state_exception => |e| e.message,
                .operation_in_progress_exception => |e| e.message,
                .platform_version_still_referenced_exception => |e| e.message,
                .resource_not_found_exception => |e| e.message,
                .resource_type_not_supported_exception => |e| e.message,
                .s3_location_not_in_service_region_exception => |e| e.message,
                .s3_subscription_required_exception => |e| e.message,
                .source_bundle_deletion_exception => |e| e.message,
                .too_many_application_versions_exception => |e| e.message,
                .too_many_applications_exception => |e| e.message,
                .too_many_buckets_exception => |e| e.message,
                .too_many_configuration_templates_exception => |e| e.message,
                .too_many_environments_exception => |e| e.message,
                .too_many_platforms_exception => |e| e.message,
                .too_many_tags_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .code_build_not_in_service_region_exception => 400,
                .elastic_beanstalk_service_exception => 400,
                .insufficient_privileges_exception => 403,
                .invalid_request_exception => 400,
                .managed_action_invalid_state_exception => 400,
                .operation_in_progress_exception => 400,
                .platform_version_still_referenced_exception => 400,
                .resource_not_found_exception => 400,
                .resource_type_not_supported_exception => 400,
                .s3_location_not_in_service_region_exception => 400,
                .s3_subscription_required_exception => 400,
                .source_bundle_deletion_exception => 400,
                .too_many_application_versions_exception => 400,
                .too_many_applications_exception => 400,
                .too_many_buckets_exception => 400,
                .too_many_configuration_templates_exception => 400,
                .too_many_environments_exception => 400,
                .too_many_platforms_exception => 400,
                .too_many_tags_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .code_build_not_in_service_region_exception => |e| e.request_id,
                .elastic_beanstalk_service_exception => |e| e.request_id,
                .insufficient_privileges_exception => |e| e.request_id,
                .invalid_request_exception => |e| e.request_id,
                .managed_action_invalid_state_exception => |e| e.request_id,
                .operation_in_progress_exception => |e| e.request_id,
                .platform_version_still_referenced_exception => |e| e.request_id,
                .resource_not_found_exception => |e| e.request_id,
                .resource_type_not_supported_exception => |e| e.request_id,
                .s3_location_not_in_service_region_exception => |e| e.request_id,
                .s3_subscription_required_exception => |e| e.request_id,
                .source_bundle_deletion_exception => |e| e.request_id,
                .too_many_application_versions_exception => |e| e.request_id,
                .too_many_applications_exception => |e| e.request_id,
                .too_many_buckets_exception => |e| e.request_id,
                .too_many_configuration_templates_exception => |e| e.request_id,
                .too_many_environments_exception => |e| e.request_id,
                .too_many_platforms_exception => |e| e.request_id,
                .too_many_tags_exception => |e| e.request_id,
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

pub const CodeBuildNotInServiceRegionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ElasticBeanstalkServiceException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InsufficientPrivilegesException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ManagedActionInvalidStateException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OperationInProgressException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PlatformVersionStillReferencedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ResourceTypeNotSupportedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const S3LocationNotInServiceRegionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const S3SubscriptionRequiredException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SourceBundleDeletionException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyApplicationVersionsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyApplicationsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyBucketsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyConfigurationTemplatesException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyEnvironmentsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyPlatformsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyTagsException = struct {
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
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "CodeBuildNotInServiceRegionException")) {
        return .{ .arena = arena, .kind = .{ .code_build_not_in_service_region_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ElasticBeanstalkServiceException")) {
        return .{ .arena = arena, .kind = .{ .elastic_beanstalk_service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientPrivilegesException")) {
        return .{ .arena = arena, .kind = .{ .insufficient_privileges_exception = .{
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
    if (std.mem.eql(u8, error_code, "ManagedActionInvalidStateException")) {
        return .{ .arena = arena, .kind = .{ .managed_action_invalid_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationInProgressException")) {
        return .{ .arena = arena, .kind = .{ .operation_in_progress_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PlatformVersionStillReferencedException")) {
        return .{ .arena = arena, .kind = .{ .platform_version_still_referenced_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceTypeNotSupportedException")) {
        return .{ .arena = arena, .kind = .{ .resource_type_not_supported_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "S3LocationNotInServiceRegionException")) {
        return .{ .arena = arena, .kind = .{ .s3_location_not_in_service_region_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "S3SubscriptionRequiredException")) {
        return .{ .arena = arena, .kind = .{ .s3_subscription_required_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SourceBundleDeletionException")) {
        return .{ .arena = arena, .kind = .{ .source_bundle_deletion_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyApplicationVersionsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_application_versions_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyApplicationsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_applications_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyBucketsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_buckets_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyConfigurationTemplatesException")) {
        return .{ .arena = arena, .kind = .{ .too_many_configuration_templates_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyEnvironmentsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_environments_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyPlatformsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_platforms_exception = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
