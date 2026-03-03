const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AutoScalingConfiguration = @import("auto_scaling_configuration.zig").AutoScalingConfiguration;
const KxAzMode = @import("kx_az_mode.zig").KxAzMode;
const KxCacheStorageConfiguration = @import("kx_cache_storage_configuration.zig").KxCacheStorageConfiguration;
const CapacityConfiguration = @import("capacity_configuration.zig").CapacityConfiguration;
const KxClusterType = @import("kx_cluster_type.zig").KxClusterType;
const CodeConfiguration = @import("code_configuration.zig").CodeConfiguration;
const KxCommandLineArgument = @import("kx_command_line_argument.zig").KxCommandLineArgument;
const KxDatabaseConfiguration = @import("kx_database_configuration.zig").KxDatabaseConfiguration;
const KxSavedownStorageConfiguration = @import("kx_savedown_storage_configuration.zig").KxSavedownStorageConfiguration;
const KxScalingGroupConfiguration = @import("kx_scaling_group_configuration.zig").KxScalingGroupConfiguration;
const KxClusterStatus = @import("kx_cluster_status.zig").KxClusterStatus;
const TickerplantLogConfiguration = @import("tickerplant_log_configuration.zig").TickerplantLogConfiguration;
const Volume = @import("volume.zig").Volume;
const VpcConfiguration = @import("vpc_configuration.zig").VpcConfiguration;

pub const GetKxClusterInput = struct {
    /// The name of the cluster that you want to retrieve.
    cluster_name: []const u8,

    /// A unique identifier for the kdb environment.
    environment_id: []const u8,

    pub const json_field_names = .{
        .cluster_name = "clusterName",
        .environment_id = "environmentId",
    };
};

pub const GetKxClusterOutput = struct {
    /// The configuration based on which FinSpace will scale in or scale out nodes
    /// in your cluster.
    auto_scaling_configuration: ?AutoScalingConfiguration = null,

    /// The availability zone identifiers for the requested regions.
    availability_zone_id: ?[]const u8 = null,

    /// The number of availability zones you want to assign per cluster. This can be
    /// one of the following
    ///
    /// * `SINGLE` – Assigns one availability zone per cluster.
    ///
    /// * `MULTI` – Assigns all the availability zones per cluster.
    az_mode: ?KxAzMode = null,

    /// The configurations for a read only cache storage associated with a cluster.
    /// This cache will be stored as an FSx Lustre that reads from the S3 store.
    cache_storage_configurations: ?[]const KxCacheStorageConfiguration = null,

    /// A structure for the metadata of a cluster. It includes information like the
    /// CPUs needed, memory of instances, and number of instances.
    capacity_configuration: ?CapacityConfiguration = null,

    /// A description of the cluster.
    cluster_description: ?[]const u8 = null,

    /// A unique name for the cluster.
    cluster_name: ?[]const u8 = null,

    /// Specifies the type of KDB database that is being created. The following
    /// types are available:
    ///
    /// * HDB – A Historical Database. The data is only accessible with read-only
    ///   permissions from one of the FinSpace managed kdb databases mounted to the
    ///   cluster.
    ///
    /// * RDB – A Realtime Database. This type of database captures all the data
    ///   from a ticker plant and stores it in memory until the end of day, after
    ///   which it writes all of its data to a disk and reloads the HDB. This
    ///   cluster type requires local storage for temporary storage of data during
    ///   the savedown process. If you specify this field in your request, you must
    ///   provide the `savedownStorageConfiguration` parameter.
    ///
    /// * GATEWAY – A gateway cluster allows you to access data across processes in
    ///   kdb systems. It allows you to create your own routing logic using the
    ///   initialization scripts and custom code. This type of cluster does not
    ///   require a writable local storage.
    ///
    /// * GP – A general purpose cluster allows you to quickly iterate on code
    ///   during development by granting greater access to system commands and
    ///   enabling a fast reload of custom code. This cluster type can optionally
    ///   mount databases including cache and savedown storage. For this cluster
    ///   type, the node count is fixed at 1. It does not support autoscaling and
    ///   supports only `SINGLE` AZ mode.
    ///
    /// * Tickerplant – A tickerplant cluster allows you to subscribe to feed
    ///   handlers based on IAM permissions. It can publish to RDBs, other
    ///   Tickerplants, and real-time subscribers (RTS). Tickerplants can persist
    ///   messages to log, which is readable by any RDB environment. It supports
    ///   only single-node that is only one kdb process.
    cluster_type: ?KxClusterType = null,

    /// The details of the custom code that you want to use inside a cluster when
    /// analyzing a data. It consists of the S3 source bucket, location, S3 object
    /// version, and the relative path from where the custom code is loaded into the
    /// cluster.
    code: ?CodeConfiguration = null,

    /// Defines key-value pairs to make them available inside the cluster.
    command_line_arguments: ?[]const KxCommandLineArgument = null,

    /// The timestamp at which the cluster was created in FinSpace. The value is
    /// determined as epoch time in milliseconds. For example, the value for Monday,
    /// November 1, 2021 12:00:00 PM UTC is specified as 1635768000000.
    created_timestamp: ?i64 = null,

    /// A list of databases mounted on the cluster.
    databases: ?[]const KxDatabaseConfiguration = null,

    /// An IAM role that defines a set of permissions associated with a cluster.
    /// These permissions are assumed when a cluster attempts to access another
    /// cluster.
    execution_role: ?[]const u8 = null,

    /// Specifies a Q program that will be run at launch of a cluster. It is a
    /// relative path within
    /// *.zip* file that contains the custom code, which will be loaded on
    /// the cluster. It must include the file name itself. For example,
    /// `somedir/init.q`.
    initialization_script: ?[]const u8 = null,

    /// The last time that the cluster was modified. The value is determined as
    /// epoch time in milliseconds. For example, the value for Monday, November 1,
    /// 2021 12:00:00 PM UTC is specified as 1635768000000.
    last_modified_timestamp: ?i64 = null,

    /// The version of FinSpace managed kdb to run.
    release_label: ?[]const u8 = null,

    /// The size and type of the temporary storage that is used to hold data during
    /// the savedown process. This parameter is required when you choose
    /// `clusterType` as RDB. All the data written to this storage space is lost
    /// when the cluster node is restarted.
    savedown_storage_configuration: ?KxSavedownStorageConfiguration = null,

    scaling_group_configuration: ?KxScalingGroupConfiguration = null,

    /// The status of cluster creation.
    ///
    /// * PENDING – The cluster is pending creation.
    ///
    /// * CREATING – The cluster creation process is in progress.
    ///
    /// * CREATE_FAILED – The cluster creation process has failed.
    ///
    /// * RUNNING – The cluster creation process is running.
    ///
    /// * UPDATING – The cluster is in the process of being updated.
    ///
    /// * DELETING – The cluster is in the process of being deleted.
    ///
    /// * DELETED – The cluster has been deleted.
    ///
    /// * DELETE_FAILED – The cluster failed to delete.
    status: ?KxClusterStatus = null,

    /// The error message when a failed state occurs.
    status_reason: ?[]const u8 = null,

    tickerplant_log_configuration: ?TickerplantLogConfiguration = null,

    /// A list of volumes attached to the cluster.
    volumes: ?[]const Volume = null,

    /// Configuration details about the network where the Privatelink endpoint of
    /// the cluster resides.
    vpc_configuration: ?VpcConfiguration = null,

    pub const json_field_names = .{
        .auto_scaling_configuration = "autoScalingConfiguration",
        .availability_zone_id = "availabilityZoneId",
        .az_mode = "azMode",
        .cache_storage_configurations = "cacheStorageConfigurations",
        .capacity_configuration = "capacityConfiguration",
        .cluster_description = "clusterDescription",
        .cluster_name = "clusterName",
        .cluster_type = "clusterType",
        .code = "code",
        .command_line_arguments = "commandLineArguments",
        .created_timestamp = "createdTimestamp",
        .databases = "databases",
        .execution_role = "executionRole",
        .initialization_script = "initializationScript",
        .last_modified_timestamp = "lastModifiedTimestamp",
        .release_label = "releaseLabel",
        .savedown_storage_configuration = "savedownStorageConfiguration",
        .scaling_group_configuration = "scalingGroupConfiguration",
        .status = "status",
        .status_reason = "statusReason",
        .tickerplant_log_configuration = "tickerplantLogConfiguration",
        .volumes = "volumes",
        .vpc_configuration = "vpcConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetKxClusterInput, options: CallOptions) !GetKxClusterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "finspace");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetKxClusterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("finspace", "finspace", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/kx/environments/");
    try path_buf.appendSlice(allocator, input.environment_id);
    try path_buf.appendSlice(allocator, "/clusters/");
    try path_buf.appendSlice(allocator, input.cluster_name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetKxClusterOutput {
    var result: GetKxClusterOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetKxClusterOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
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
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
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
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
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
