const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_point_not_found_exception: AccessPointNotFoundException,
        certificate_not_found_exception: CertificateNotFoundException,
        dependency_throttle_exception: DependencyThrottleException,
        duplicate_access_point_name_exception: DuplicateAccessPointNameException,
        duplicate_listener_exception: DuplicateListenerException,
        duplicate_policy_name_exception: DuplicatePolicyNameException,
        duplicate_tag_keys_exception: DuplicateTagKeysException,
        invalid_configuration_request_exception: InvalidConfigurationRequestException,
        invalid_end_point_exception: InvalidEndPointException,
        invalid_scheme_exception: InvalidSchemeException,
        invalid_security_group_exception: InvalidSecurityGroupException,
        invalid_subnet_exception: InvalidSubnetException,
        listener_not_found_exception: ListenerNotFoundException,
        load_balancer_attribute_not_found_exception: LoadBalancerAttributeNotFoundException,
        operation_not_permitted_exception: OperationNotPermittedException,
        policy_not_found_exception: PolicyNotFoundException,
        policy_type_not_found_exception: PolicyTypeNotFoundException,
        subnet_not_found_exception: SubnetNotFoundException,
        too_many_access_points_exception: TooManyAccessPointsException,
        too_many_policies_exception: TooManyPoliciesException,
        too_many_tags_exception: TooManyTagsException,
        unsupported_protocol_exception: UnsupportedProtocolException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_point_not_found_exception => "AccessPointNotFoundException",
                .certificate_not_found_exception => "CertificateNotFoundException",
                .dependency_throttle_exception => "DependencyThrottleException",
                .duplicate_access_point_name_exception => "DuplicateAccessPointNameException",
                .duplicate_listener_exception => "DuplicateListenerException",
                .duplicate_policy_name_exception => "DuplicatePolicyNameException",
                .duplicate_tag_keys_exception => "DuplicateTagKeysException",
                .invalid_configuration_request_exception => "InvalidConfigurationRequestException",
                .invalid_end_point_exception => "InvalidEndPointException",
                .invalid_scheme_exception => "InvalidSchemeException",
                .invalid_security_group_exception => "InvalidSecurityGroupException",
                .invalid_subnet_exception => "InvalidSubnetException",
                .listener_not_found_exception => "ListenerNotFoundException",
                .load_balancer_attribute_not_found_exception => "LoadBalancerAttributeNotFoundException",
                .operation_not_permitted_exception => "OperationNotPermittedException",
                .policy_not_found_exception => "PolicyNotFoundException",
                .policy_type_not_found_exception => "PolicyTypeNotFoundException",
                .subnet_not_found_exception => "SubnetNotFoundException",
                .too_many_access_points_exception => "TooManyAccessPointsException",
                .too_many_policies_exception => "TooManyPoliciesException",
                .too_many_tags_exception => "TooManyTagsException",
                .unsupported_protocol_exception => "UnsupportedProtocolException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_point_not_found_exception => |e| e.message,
                .certificate_not_found_exception => |e| e.message,
                .dependency_throttle_exception => |e| e.message,
                .duplicate_access_point_name_exception => |e| e.message,
                .duplicate_listener_exception => |e| e.message,
                .duplicate_policy_name_exception => |e| e.message,
                .duplicate_tag_keys_exception => |e| e.message,
                .invalid_configuration_request_exception => |e| e.message,
                .invalid_end_point_exception => |e| e.message,
                .invalid_scheme_exception => |e| e.message,
                .invalid_security_group_exception => |e| e.message,
                .invalid_subnet_exception => |e| e.message,
                .listener_not_found_exception => |e| e.message,
                .load_balancer_attribute_not_found_exception => |e| e.message,
                .operation_not_permitted_exception => |e| e.message,
                .policy_not_found_exception => |e| e.message,
                .policy_type_not_found_exception => |e| e.message,
                .subnet_not_found_exception => |e| e.message,
                .too_many_access_points_exception => |e| e.message,
                .too_many_policies_exception => |e| e.message,
                .too_many_tags_exception => |e| e.message,
                .unsupported_protocol_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_point_not_found_exception => 400,
                .certificate_not_found_exception => 400,
                .dependency_throttle_exception => 400,
                .duplicate_access_point_name_exception => 400,
                .duplicate_listener_exception => 400,
                .duplicate_policy_name_exception => 400,
                .duplicate_tag_keys_exception => 400,
                .invalid_configuration_request_exception => 409,
                .invalid_end_point_exception => 400,
                .invalid_scheme_exception => 400,
                .invalid_security_group_exception => 400,
                .invalid_subnet_exception => 400,
                .listener_not_found_exception => 400,
                .load_balancer_attribute_not_found_exception => 400,
                .operation_not_permitted_exception => 400,
                .policy_not_found_exception => 400,
                .policy_type_not_found_exception => 400,
                .subnet_not_found_exception => 400,
                .too_many_access_points_exception => 400,
                .too_many_policies_exception => 400,
                .too_many_tags_exception => 400,
                .unsupported_protocol_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_point_not_found_exception => |e| e.request_id,
                .certificate_not_found_exception => |e| e.request_id,
                .dependency_throttle_exception => |e| e.request_id,
                .duplicate_access_point_name_exception => |e| e.request_id,
                .duplicate_listener_exception => |e| e.request_id,
                .duplicate_policy_name_exception => |e| e.request_id,
                .duplicate_tag_keys_exception => |e| e.request_id,
                .invalid_configuration_request_exception => |e| e.request_id,
                .invalid_end_point_exception => |e| e.request_id,
                .invalid_scheme_exception => |e| e.request_id,
                .invalid_security_group_exception => |e| e.request_id,
                .invalid_subnet_exception => |e| e.request_id,
                .listener_not_found_exception => |e| e.request_id,
                .load_balancer_attribute_not_found_exception => |e| e.request_id,
                .operation_not_permitted_exception => |e| e.request_id,
                .policy_not_found_exception => |e| e.request_id,
                .policy_type_not_found_exception => |e| e.request_id,
                .subnet_not_found_exception => |e| e.request_id,
                .too_many_access_points_exception => |e| e.request_id,
                .too_many_policies_exception => |e| e.request_id,
                .too_many_tags_exception => |e| e.request_id,
                .unsupported_protocol_exception => |e| e.request_id,
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

pub const AccessPointNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const CertificateNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DependencyThrottleException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DuplicateAccessPointNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DuplicateListenerException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DuplicatePolicyNameException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DuplicateTagKeysException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidConfigurationRequestException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidEndPointException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidSchemeException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidSecurityGroupException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidSubnetException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ListenerNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const LoadBalancerAttributeNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const OperationNotPermittedException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PolicyNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PolicyTypeNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SubnetNotFoundException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyAccessPointsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyPoliciesException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyTagsException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedProtocolException = struct {
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

    if (std.mem.eql(u8, error_code, "AccessPointNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .access_point_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CertificateNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .certificate_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DependencyThrottleException")) {
        return .{ .arena = arena, .kind = .{ .dependency_throttle_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateAccessPointNameException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_access_point_name_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateListenerException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_listener_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicatePolicyNameException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_policy_name_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DuplicateTagKeysException")) {
        return .{ .arena = arena, .kind = .{ .duplicate_tag_keys_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidConfigurationRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_configuration_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidEndPointException")) {
        return .{ .arena = arena, .kind = .{ .invalid_end_point_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSchemeException")) {
        return .{ .arena = arena, .kind = .{ .invalid_scheme_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSecurityGroupException")) {
        return .{ .arena = arena, .kind = .{ .invalid_security_group_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidSubnetException")) {
        return .{ .arena = arena, .kind = .{ .invalid_subnet_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ListenerNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .listener_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LoadBalancerAttributeNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .load_balancer_attribute_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "OperationNotPermittedException")) {
        return .{ .arena = arena, .kind = .{ .operation_not_permitted_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PolicyNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .policy_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PolicyTypeNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .policy_type_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubnetNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .subnet_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyAccessPointsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_access_points_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyPoliciesException")) {
        return .{ .arena = arena, .kind = .{ .too_many_policies_exception = .{
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
    if (std.mem.eql(u8, error_code, "UnsupportedProtocolException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_protocol_exception = .{
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
