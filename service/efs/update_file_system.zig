const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ThroughputMode = @import("throughput_mode.zig").ThroughputMode;
const FileSystemProtectionDescription = @import("file_system_protection_description.zig").FileSystemProtectionDescription;
const LifeCycleState = @import("life_cycle_state.zig").LifeCycleState;
const PerformanceMode = @import("performance_mode.zig").PerformanceMode;
const FileSystemSize = @import("file_system_size.zig").FileSystemSize;
const Tag = @import("tag.zig").Tag;

pub const UpdateFileSystemInput = struct {
    /// The ID of the file system that you want to update.
    file_system_id: []const u8,

    /// (Optional) The throughput, measured in mebibytes per second (MiBps), that
    /// you want to
    /// provision for a file system that you're creating. Required if
    /// `ThroughputMode`
    /// is set to `provisioned`. Valid values are 1-3414 MiBps, with the upper limit
    /// depending on Region. To increase this limit, contact Amazon Web
    /// ServicesSupport. For more information,
    /// see [Amazon EFS
    /// quotas that you can
    /// increase](https://docs.aws.amazon.com/efs/latest/ug/limits.html#soft-limits)
    /// in the *Amazon EFS User
    /// Guide*.
    provisioned_throughput_in_mibps: ?f64 = null,

    /// (Optional) Updates the file system's throughput mode. If you're not
    /// updating your throughput mode, you don't need to provide this value in your
    /// request. If you are changing the `ThroughputMode` to `provisioned`,
    /// you must also set a value for `ProvisionedThroughputInMibps`.
    throughput_mode: ?ThroughputMode = null,

    pub const json_field_names = .{
        .file_system_id = "FileSystemId",
        .provisioned_throughput_in_mibps = "ProvisionedThroughputInMibps",
        .throughput_mode = "ThroughputMode",
    };
};

pub const UpdateFileSystemOutput = struct {
    /// The unique and consistent identifier of the Availability Zone in which the
    /// file system is
    /// located, and is valid only for One Zone file systems. For example,
    /// `use1-az1` is an Availability Zone ID for the us-east-1 Amazon Web Services
    /// Region, and
    /// it has the same location in every Amazon Web Services account.
    availability_zone_id: ?[]const u8 = null,

    /// Describes the Amazon Web Services Availability Zone in which the file system
    /// is located, and is
    /// valid only for One Zone file systems. For more information, see [Using EFS
    /// storage
    /// classes](https://docs.aws.amazon.com/efs/latest/ug/storage-classes.html) in
    /// the *Amazon EFS User Guide*.
    availability_zone_name: ?[]const u8 = null,

    /// The time that the file system was created, in seconds (since
    /// 1970-01-01T00:00:00Z).
    creation_time: i64,

    /// The opaque string specified in the request.
    creation_token: []const u8,

    /// A Boolean value that, if true, indicates that the file system is encrypted.
    encrypted: ?bool = null,

    /// The Amazon Resource Name (ARN) for the EFS file system, in the
    /// format
    /// `arn:aws:elasticfilesystem:*region*:*account-id*:file-system/*file-system-id*
    /// `.
    /// Example with sample data:
    /// `arn:aws:elasticfilesystem:us-west-2:1111333322228888:file-system/fs-01234567`
    file_system_arn: ?[]const u8 = null,

    /// The ID of the file system, assigned by Amazon EFS.
    file_system_id: []const u8,

    /// Describes the protection on the file system.
    file_system_protection: ?FileSystemProtectionDescription = null,

    /// The ID of an KMS key used to protect the encrypted file system.
    kms_key_id: ?[]const u8 = null,

    /// The lifecycle phase of the file system.
    life_cycle_state: LifeCycleState,

    /// You can add tags to a file system, including a `Name` tag. For more
    /// information, see CreateFileSystem. If the file system has a `Name` tag,
    /// Amazon EFS returns
    /// the value in this field.
    name: ?[]const u8 = null,

    /// The current number of mount targets that the file system has. For more
    /// information, see CreateMountTarget.
    number_of_mount_targets: i32 = 0,

    /// The Amazon Web Services account that created the file system.
    owner_id: []const u8,

    /// The performance mode of the file system.
    performance_mode: PerformanceMode,

    /// The amount of provisioned throughput, measured in MiBps, for the file
    /// system. Valid for
    /// file systems using `ThroughputMode` set to `provisioned`.
    provisioned_throughput_in_mibps: ?f64 = null,

    /// The latest known metered size (in bytes) of data stored in the file system,
    /// in its
    /// `Value` field, and the time at which that size was determined in its
    /// `Timestamp` field. The `Timestamp` value is the integer number of
    /// seconds since 1970-01-01T00:00:00Z. The `SizeInBytes` value doesn't
    /// represent
    /// the size of a consistent snapshot of the file system, but it is eventually
    /// consistent when
    /// there are no writes to the file system. That is, `SizeInBytes` represents
    /// actual
    /// size only if the file system is not modified for a period longer than a
    /// couple of hours.
    /// Otherwise, the value is not the exact size that the file system was at any
    /// point in time.
    size_in_bytes: ?FileSystemSize = null,

    /// The tags associated with the file system, presented as an array of `Tag`
    /// objects.
    tags: ?[]const Tag = null,

    /// Displays the file system's throughput mode. For more information, see
    /// [Throughput
    /// modes](https://docs.aws.amazon.com/efs/latest/ug/performance.html#throughput-modes)
    /// in the *Amazon EFS User Guide*.
    throughput_mode: ?ThroughputMode = null,

    pub const json_field_names = .{
        .availability_zone_id = "AvailabilityZoneId",
        .availability_zone_name = "AvailabilityZoneName",
        .creation_time = "CreationTime",
        .creation_token = "CreationToken",
        .encrypted = "Encrypted",
        .file_system_arn = "FileSystemArn",
        .file_system_id = "FileSystemId",
        .file_system_protection = "FileSystemProtection",
        .kms_key_id = "KmsKeyId",
        .life_cycle_state = "LifeCycleState",
        .name = "Name",
        .number_of_mount_targets = "NumberOfMountTargets",
        .owner_id = "OwnerId",
        .performance_mode = "PerformanceMode",
        .provisioned_throughput_in_mibps = "ProvisionedThroughputInMibps",
        .size_in_bytes = "SizeInBytes",
        .tags = "Tags",
        .throughput_mode = "ThroughputMode",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateFileSystemInput, options: Options) !UpdateFileSystemOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "efs");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateFileSystemInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("efs", "EFS", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/2015-02-01/file-systems/");
    try path_buf.appendSlice(alloc, input.file_system_id);
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.provisioned_throughput_in_mibps) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ProvisionedThroughputInMibps\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.throughput_mode) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ThroughputMode\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateFileSystemOutput {
    var result: UpdateFileSystemOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateFileSystemOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
