const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const PerformanceMode = @import("performance_mode.zig").PerformanceMode;
const Tag = @import("tag.zig").Tag;
const ThroughputMode = @import("throughput_mode.zig").ThroughputMode;
const FileSystemProtectionDescription = @import("file_system_protection_description.zig").FileSystemProtectionDescription;
const LifeCycleState = @import("life_cycle_state.zig").LifeCycleState;
const FileSystemSize = @import("file_system_size.zig").FileSystemSize;

pub const CreateFileSystemInput = struct {
    /// For One Zone file systems, specify the Amazon Web Services
    /// Availability Zone in which to create the file system. Use the format
    /// `us-east-1a` to
    /// specify the Availability Zone. For more information about One Zone file
    /// systems, see
    /// [EFS file system
    /// types](https://docs.aws.amazon.com/efs/latest/ug/availability-durability.html#file-system-type) in the *Amazon EFS User Guide*.
    ///
    /// One Zone file systems are not available in all Availability Zones in Amazon
    /// Web Services Regions where Amazon EFS is available.
    availability_zone_name: ?[]const u8 = null,

    /// Specifies whether automatic backups are enabled on the file system that you
    /// are creating.
    /// Set the value to `true` to enable automatic backups. If you are creating a
    /// One Zone file system, automatic backups are enabled by default. For more
    /// information, see [Automatic
    /// backups](https://docs.aws.amazon.com/efs/latest/ug/awsbackup.html#automatic-backups) in the
    /// *Amazon EFS User Guide*.
    ///
    /// Default is `false`. However, if you specify an `AvailabilityZoneName`,
    /// the default is `true`.
    ///
    /// Backup is not available in all Amazon Web Services Regions where Amazon EFS
    /// is available.
    backup: ?bool = null,

    /// A string of up to 64 ASCII characters. Amazon EFS uses this to ensure
    /// idempotent
    /// creation.
    creation_token: []const u8,

    /// A Boolean value that, if true, creates an encrypted file system. When
    /// creating an
    /// encrypted file system, you have the option of specifying an existing Key
    /// Management Service key (KMS key).
    /// If you don't specify a KMS key, then the default KMS key for
    /// Amazon EFS, `/aws/elasticfilesystem`, is used to protect the encrypted file
    /// system.
    encrypted: ?bool = null,

    /// The ID of the KMS key that you want to use to protect the encrypted file
    /// system. This parameter is required only if you want to use a non-default KMS
    /// key. If this parameter is not specified, the default KMS key for Amazon EFS
    /// is used. You can specify a KMS key ID using the following
    /// formats:
    ///
    /// * Key ID - A unique identifier of the key, for example
    /// `1234abcd-12ab-34cd-56ef-1234567890ab`.
    ///
    /// * ARN - An Amazon Resource Name (ARN) for the key, for example
    /// `arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab`.
    ///
    /// * Key alias - A previously created display name for a key, for example
    /// `alias/projectKey1`.
    ///
    /// * Key alias ARN - An ARN for a key alias, for example
    /// `arn:aws:kms:us-west-2:444455556666:alias/projectKey1`.
    ///
    /// If you use `KmsKeyId`, you must set the CreateFileSystemRequest$Encrypted
    /// parameter to true.
    ///
    /// EFS accepts only symmetric KMS keys. You cannot use asymmetric
    /// KMS keys with Amazon EFS file systems.
    kms_key_id: ?[]const u8 = null,

    /// The performance mode of the file system. We recommend `generalPurpose`
    /// performance mode for all file systems. File systems using the `maxIO`
    /// performance
    /// mode can scale to higher levels of aggregate throughput and operations per
    /// second with a
    /// tradeoff of slightly higher latencies for most file operations. The
    /// performance mode
    /// can't be changed after the file system has been created. The `maxIO` mode is
    /// not supported on One Zone file systems.
    ///
    /// Due to the higher per-operation latencies with Max I/O, we recommend using
    /// General Purpose performance mode for all file systems.
    ///
    /// Default is `generalPurpose`.
    performance_mode: ?PerformanceMode = null,

    /// The throughput, measured in mebibytes per second (MiBps), that you want to
    /// provision for a
    /// file system that you're creating. Required if `ThroughputMode` is set to
    /// `provisioned`. Valid values are 1-3414 MiBps, with the upper limit depending
    /// on
    /// Region. To increase this limit, contact Amazon Web ServicesSupport. For more
    /// information, see [Amazon EFS quotas
    /// that you can
    /// increase](https://docs.aws.amazon.com/efs/latest/ug/limits.html#soft-limits)
    /// in the *Amazon EFS User
    /// Guide*.
    provisioned_throughput_in_mibps: ?f64 = null,

    /// Use to create one or more tags associated with the file system. Each
    /// tag is a user-defined key-value pair. Name your file system on creation by
    /// including a
    /// `"Key":"Name","Value":"{value}"` key-value pair. Each key must be unique.
    /// For more
    /// information, see [Tagging Amazon Web Services
    /// resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    /// in the *Amazon Web Services General Reference Guide*.
    tags: ?[]const Tag = null,

    /// Specifies the throughput mode for the file system. The mode can be
    /// `bursting`,
    /// `provisioned`, or `elastic`. If you set `ThroughputMode` to
    /// `provisioned`, you must also set a value for
    /// `ProvisionedThroughputInMibps`. After you create the file system, you can
    /// decrease your file system's Provisioned throughput or change between the
    /// throughput modes, with certain time restrictions. For more information, see
    /// [Specifying
    /// throughput with provisioned
    /// mode](https://docs.aws.amazon.com/efs/latest/ug/performance.html#provisioned-throughput) in the *Amazon EFS User
    /// Guide*.
    ///
    /// Default is `bursting`.
    throughput_mode: ?ThroughputMode = null,

    pub const json_field_names = .{
        .availability_zone_name = "AvailabilityZoneName",
        .backup = "Backup",
        .creation_token = "CreationToken",
        .encrypted = "Encrypted",
        .kms_key_id = "KmsKeyId",
        .performance_mode = "PerformanceMode",
        .provisioned_throughput_in_mibps = "ProvisionedThroughputInMibps",
        .tags = "Tags",
        .throughput_mode = "ThroughputMode",
    };
};

const CreateFileSystemOutput = @import("file_system_description.zig").FileSystemDescription;

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFileSystemInput, options: Options) !CreateFileSystemOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFileSystemInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("efs", "EFS", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/2015-02-01/file-systems";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.availability_zone_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AvailabilityZoneName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.backup) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Backup\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"CreationToken\":");
    try aws.json.writeValue(@TypeOf(input.creation_token), input.creation_token, allocator, &body_buf);
    has_prev = true;
    if (input.encrypted) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Encrypted\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"KmsKeyId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.performance_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PerformanceMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.provisioned_throughput_in_mibps) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ProvisionedThroughputInMibps\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.throughput_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ThroughputMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFileSystemOutput {
    var result: CreateFileSystemOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateFileSystemOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
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
