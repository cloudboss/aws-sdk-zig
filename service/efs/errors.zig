const aws = @import("aws");
const std = @import("std");

pub const ServiceError = struct {
    arena: ?std.heap.ArenaAllocator = null,
    kind: Kind,

    pub const Kind = union(enum) {
        access_point_already_exists: AccessPointAlreadyExists,
        access_point_limit_exceeded: AccessPointLimitExceeded,
        access_point_not_found: AccessPointNotFound,
        availability_zones_mismatch: AvailabilityZonesMismatch,
        bad_request: BadRequest,
        conflict_exception: ConflictException,
        dependency_timeout: DependencyTimeout,
        file_system_already_exists: FileSystemAlreadyExists,
        file_system_in_use: FileSystemInUse,
        file_system_limit_exceeded: FileSystemLimitExceeded,
        file_system_not_found: FileSystemNotFound,
        incorrect_file_system_life_cycle_state: IncorrectFileSystemLifeCycleState,
        incorrect_mount_target_state: IncorrectMountTargetState,
        insufficient_throughput_capacity: InsufficientThroughputCapacity,
        internal_server_error: InternalServerError,
        invalid_policy_exception: InvalidPolicyException,
        ip_address_in_use: IpAddressInUse,
        mount_target_conflict: MountTargetConflict,
        mount_target_not_found: MountTargetNotFound,
        network_interface_limit_exceeded: NetworkInterfaceLimitExceeded,
        no_free_addresses_in_subnet: NoFreeAddressesInSubnet,
        policy_not_found: PolicyNotFound,
        replication_already_exists: ReplicationAlreadyExists,
        replication_not_found: ReplicationNotFound,
        security_group_limit_exceeded: SecurityGroupLimitExceeded,
        security_group_not_found: SecurityGroupNotFound,
        subnet_not_found: SubnetNotFound,
        throttling_exception: ThrottlingException,
        throughput_limit_exceeded: ThroughputLimitExceeded,
        too_many_requests: TooManyRequests,
        unsupported_availability_zone: UnsupportedAvailabilityZone,
        validation_exception: ValidationException,
        unknown: UnknownServiceError,

        pub fn code(self: Kind) []const u8 {
            return switch (self) {
                .access_point_already_exists => "AccessPointAlreadyExists",
                .access_point_limit_exceeded => "AccessPointLimitExceeded",
                .access_point_not_found => "AccessPointNotFound",
                .availability_zones_mismatch => "AvailabilityZonesMismatch",
                .bad_request => "BadRequest",
                .conflict_exception => "ConflictException",
                .dependency_timeout => "DependencyTimeout",
                .file_system_already_exists => "FileSystemAlreadyExists",
                .file_system_in_use => "FileSystemInUse",
                .file_system_limit_exceeded => "FileSystemLimitExceeded",
                .file_system_not_found => "FileSystemNotFound",
                .incorrect_file_system_life_cycle_state => "IncorrectFileSystemLifeCycleState",
                .incorrect_mount_target_state => "IncorrectMountTargetState",
                .insufficient_throughput_capacity => "InsufficientThroughputCapacity",
                .internal_server_error => "InternalServerError",
                .invalid_policy_exception => "InvalidPolicyException",
                .ip_address_in_use => "IpAddressInUse",
                .mount_target_conflict => "MountTargetConflict",
                .mount_target_not_found => "MountTargetNotFound",
                .network_interface_limit_exceeded => "NetworkInterfaceLimitExceeded",
                .no_free_addresses_in_subnet => "NoFreeAddressesInSubnet",
                .policy_not_found => "PolicyNotFound",
                .replication_already_exists => "ReplicationAlreadyExists",
                .replication_not_found => "ReplicationNotFound",
                .security_group_limit_exceeded => "SecurityGroupLimitExceeded",
                .security_group_not_found => "SecurityGroupNotFound",
                .subnet_not_found => "SubnetNotFound",
                .throttling_exception => "ThrottlingException",
                .throughput_limit_exceeded => "ThroughputLimitExceeded",
                .too_many_requests => "TooManyRequests",
                .unsupported_availability_zone => "UnsupportedAvailabilityZone",
                .validation_exception => "ValidationException",
                .unknown => |e| e.code,
            };
        }

        pub fn message(self: Kind) []const u8 {
            return switch (self) {
                .access_point_already_exists => |e| e.message,
                .access_point_limit_exceeded => |e| e.message,
                .access_point_not_found => |e| e.message,
                .availability_zones_mismatch => |e| e.message,
                .bad_request => |e| e.message,
                .conflict_exception => |e| e.message,
                .dependency_timeout => |e| e.message,
                .file_system_already_exists => |e| e.message,
                .file_system_in_use => |e| e.message,
                .file_system_limit_exceeded => |e| e.message,
                .file_system_not_found => |e| e.message,
                .incorrect_file_system_life_cycle_state => |e| e.message,
                .incorrect_mount_target_state => |e| e.message,
                .insufficient_throughput_capacity => |e| e.message,
                .internal_server_error => |e| e.message,
                .invalid_policy_exception => |e| e.message,
                .ip_address_in_use => |e| e.message,
                .mount_target_conflict => |e| e.message,
                .mount_target_not_found => |e| e.message,
                .network_interface_limit_exceeded => |e| e.message,
                .no_free_addresses_in_subnet => |e| e.message,
                .policy_not_found => |e| e.message,
                .replication_already_exists => |e| e.message,
                .replication_not_found => |e| e.message,
                .security_group_limit_exceeded => |e| e.message,
                .security_group_not_found => |e| e.message,
                .subnet_not_found => |e| e.message,
                .throttling_exception => |e| e.message,
                .throughput_limit_exceeded => |e| e.message,
                .too_many_requests => |e| e.message,
                .unsupported_availability_zone => |e| e.message,
                .validation_exception => |e| e.message,
                .unknown => |e| e.message,
            };
        }

        pub fn httpStatus(self: Kind) u16 {
            return switch (self) {
                .access_point_already_exists => 409,
                .access_point_limit_exceeded => 403,
                .access_point_not_found => 404,
                .availability_zones_mismatch => 400,
                .bad_request => 400,
                .conflict_exception => 409,
                .dependency_timeout => 504,
                .file_system_already_exists => 409,
                .file_system_in_use => 409,
                .file_system_limit_exceeded => 403,
                .file_system_not_found => 404,
                .incorrect_file_system_life_cycle_state => 409,
                .incorrect_mount_target_state => 409,
                .insufficient_throughput_capacity => 503,
                .internal_server_error => 500,
                .invalid_policy_exception => 400,
                .ip_address_in_use => 409,
                .mount_target_conflict => 409,
                .mount_target_not_found => 404,
                .network_interface_limit_exceeded => 409,
                .no_free_addresses_in_subnet => 409,
                .policy_not_found => 404,
                .replication_already_exists => 409,
                .replication_not_found => 404,
                .security_group_limit_exceeded => 400,
                .security_group_not_found => 400,
                .subnet_not_found => 400,
                .throttling_exception => 429,
                .throughput_limit_exceeded => 400,
                .too_many_requests => 429,
                .unsupported_availability_zone => 400,
                .validation_exception => 400,
                .unknown => |e| e.http_status,
            };
        }

        pub fn requestId(self: Kind) []const u8 {
            return switch (self) {
                .access_point_already_exists => |e| e.request_id,
                .access_point_limit_exceeded => |e| e.request_id,
                .access_point_not_found => |e| e.request_id,
                .availability_zones_mismatch => |e| e.request_id,
                .bad_request => |e| e.request_id,
                .conflict_exception => |e| e.request_id,
                .dependency_timeout => |e| e.request_id,
                .file_system_already_exists => |e| e.request_id,
                .file_system_in_use => |e| e.request_id,
                .file_system_limit_exceeded => |e| e.request_id,
                .file_system_not_found => |e| e.request_id,
                .incorrect_file_system_life_cycle_state => |e| e.request_id,
                .incorrect_mount_target_state => |e| e.request_id,
                .insufficient_throughput_capacity => |e| e.request_id,
                .internal_server_error => |e| e.request_id,
                .invalid_policy_exception => |e| e.request_id,
                .ip_address_in_use => |e| e.request_id,
                .mount_target_conflict => |e| e.request_id,
                .mount_target_not_found => |e| e.request_id,
                .network_interface_limit_exceeded => |e| e.request_id,
                .no_free_addresses_in_subnet => |e| e.request_id,
                .policy_not_found => |e| e.request_id,
                .replication_already_exists => |e| e.request_id,
                .replication_not_found => |e| e.request_id,
                .security_group_limit_exceeded => |e| e.request_id,
                .security_group_not_found => |e| e.request_id,
                .subnet_not_found => |e| e.request_id,
                .throttling_exception => |e| e.request_id,
                .throughput_limit_exceeded => |e| e.request_id,
                .too_many_requests => |e| e.request_id,
                .unsupported_availability_zone => |e| e.request_id,
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

pub const AccessPointAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AccessPointLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AccessPointNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const AvailabilityZonesMismatch = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const BadRequest = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ConflictException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const DependencyTimeout = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FileSystemAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FileSystemInUse = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FileSystemLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const FileSystemNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IncorrectFileSystemLifeCycleState = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IncorrectMountTargetState = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InsufficientThroughputCapacity = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InternalServerError = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const InvalidPolicyException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const IpAddressInUse = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MountTargetConflict = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const MountTargetNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NetworkInterfaceLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const NoFreeAddressesInSubnet = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const PolicyNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReplicationAlreadyExists = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ReplicationNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SecurityGroupLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SecurityGroupNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const SubnetNotFound = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ThrottlingException = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const ThroughputLimitExceeded = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const TooManyRequests = struct {
    message: []const u8 = "",
    request_id: []const u8 = "",
};

pub const UnsupportedAvailabilityZone = struct {
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

    if (std.mem.eql(u8, error_code, "AccessPointAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .access_point_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AccessPointLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .access_point_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AccessPointNotFound")) {
        return .{ .arena = arena, .kind = .{ .access_point_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AvailabilityZonesMismatch")) {
        return .{ .arena = arena, .kind = .{ .availability_zones_mismatch = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BadRequest")) {
        return .{ .arena = arena, .kind = .{ .bad_request = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DependencyTimeout")) {
        return .{ .arena = arena, .kind = .{ .dependency_timeout = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FileSystemAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .file_system_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FileSystemInUse")) {
        return .{ .arena = arena, .kind = .{ .file_system_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FileSystemLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .file_system_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FileSystemNotFound")) {
        return .{ .arena = arena, .kind = .{ .file_system_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IncorrectFileSystemLifeCycleState")) {
        return .{ .arena = arena, .kind = .{ .incorrect_file_system_life_cycle_state = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IncorrectMountTargetState")) {
        return .{ .arena = arena, .kind = .{ .incorrect_mount_target_state = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientThroughputCapacity")) {
        return .{ .arena = arena, .kind = .{ .insufficient_throughput_capacity = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPolicyException")) {
        return .{ .arena = arena, .kind = .{ .invalid_policy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IpAddressInUse")) {
        return .{ .arena = arena, .kind = .{ .ip_address_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MountTargetConflict")) {
        return .{ .arena = arena, .kind = .{ .mount_target_conflict = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MountTargetNotFound")) {
        return .{ .arena = arena, .kind = .{ .mount_target_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NetworkInterfaceLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .network_interface_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoFreeAddressesInSubnet")) {
        return .{ .arena = arena, .kind = .{ .no_free_addresses_in_subnet = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PolicyNotFound")) {
        return .{ .arena = arena, .kind = .{ .policy_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReplicationAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .replication_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReplicationNotFound")) {
        return .{ .arena = arena, .kind = .{ .replication_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SecurityGroupLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .security_group_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SecurityGroupNotFound")) {
        return .{ .arena = arena, .kind = .{ .security_group_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubnetNotFound")) {
        return .{ .arena = arena, .kind = .{ .subnet_not_found = .{
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
    if (std.mem.eql(u8, error_code, "ThroughputLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .throughput_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequests")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedAvailabilityZone")) {
        return .{ .arena = arena, .kind = .{ .unsupported_availability_zone = .{
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
