const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const KerberosAuthenticationSettings = @import("kerberos_authentication_settings.zig").KerberosAuthenticationSettings;
const ReplicationInstance = @import("replication_instance.zig").ReplicationInstance;

pub const ModifyReplicationInstanceInput = struct {
    /// The amount of storage (in gigabytes) to be allocated for the replication
    /// instance.
    allocated_storage: ?i32 = null,

    /// Indicates that major version upgrades are allowed. Changing this parameter
    /// does not
    /// result in an outage, and the change is asynchronously applied as soon as
    /// possible.
    ///
    /// This parameter must be set to `true` when specifying a value for the
    /// `EngineVersion` parameter that is a different major version than the
    /// replication instance's current version.
    allow_major_version_upgrade: ?bool = null,

    /// Indicates whether the changes should be applied immediately or during the
    /// next
    /// maintenance window.
    apply_immediately: ?bool = null,

    /// A value that indicates that minor version upgrades are applied automatically
    /// to the
    /// replication instance during the maintenance window. Changing this parameter
    /// doesn't result
    /// in an outage, except in the case described following. The change is
    /// asynchronously applied
    /// as soon as possible.
    ///
    /// An outage does result if these factors apply:
    ///
    /// * This parameter is set to `true` during the maintenance window.
    ///
    /// * A newer minor version is available.
    ///
    /// * DMS has enabled automatic patching for the given engine version.
    auto_minor_version_upgrade: ?bool = null,

    /// The engine version number of the replication instance.
    ///
    /// When modifying a major engine version of an instance, also set
    /// `AllowMajorVersionUpgrade` to `true`.
    engine_version: ?[]const u8 = null,

    /// Specifies the settings required for kerberos authentication when modifying a
    /// replication
    /// instance.
    kerberos_authentication_settings: ?KerberosAuthenticationSettings = null,

    /// Specifies whether the replication instance is a Multi-AZ deployment. You
    /// can't set
    /// the `AvailabilityZone` parameter if the Multi-AZ parameter is set to
    /// `true`.
    multi_az: ?bool = null,

    /// The type of IP address protocol used by a replication instance, such as IPv4
    /// only or
    /// Dual-stack that supports both IPv4 and IPv6 addressing. IPv6 only is not yet
    /// supported.
    network_type: ?[]const u8 = null,

    /// The weekly time range (in UTC) during which system maintenance can occur,
    /// which might
    /// result in an outage. Changing this parameter does not result in an outage,
    /// except in the
    /// following situation, and the change is asynchronously applied as soon as
    /// possible. If
    /// moving this window to the current time, there must be at least 30 minutes
    /// between the
    /// current time and end of the window to ensure pending changes are applied.
    ///
    /// Default: Uses existing setting
    ///
    /// Format: ddd:hh24:mi-ddd:hh24:mi
    ///
    /// Valid Days: Mon | Tue | Wed | Thu | Fri | Sat | Sun
    ///
    /// Constraints: Must be at least 30 minutes
    preferred_maintenance_window: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the replication instance.
    replication_instance_arn: []const u8,

    /// The compute and memory capacity of the replication instance as defined for
    /// the specified
    /// replication instance class. For example to specify the instance class
    /// dms.c4.large, set
    /// this parameter to `"dms.c4.large"`.
    ///
    /// For more information on the settings and capacities for the available
    /// replication
    /// instance classes, see [ Selecting the right DMS replication instance for
    /// your
    /// migration](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_ReplicationInstance.html#CHAP_ReplicationInstance.InDepth).
    replication_instance_class: ?[]const u8 = null,

    /// The replication instance identifier. This parameter is stored as a lowercase
    /// string.
    replication_instance_identifier: ?[]const u8 = null,

    /// Specifies the VPC security group to be used with the replication instance.
    /// The VPC
    /// security group must work with the VPC containing the replication instance.
    vpc_security_group_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .allocated_storage = "AllocatedStorage",
        .allow_major_version_upgrade = "AllowMajorVersionUpgrade",
        .apply_immediately = "ApplyImmediately",
        .auto_minor_version_upgrade = "AutoMinorVersionUpgrade",
        .engine_version = "EngineVersion",
        .kerberos_authentication_settings = "KerberosAuthenticationSettings",
        .multi_az = "MultiAZ",
        .network_type = "NetworkType",
        .preferred_maintenance_window = "PreferredMaintenanceWindow",
        .replication_instance_arn = "ReplicationInstanceArn",
        .replication_instance_class = "ReplicationInstanceClass",
        .replication_instance_identifier = "ReplicationInstanceIdentifier",
        .vpc_security_group_ids = "VpcSecurityGroupIds",
    };
};

pub const ModifyReplicationInstanceOutput = struct {
    /// The modified replication instance.
    replication_instance: ?ReplicationInstance = null,

    pub const json_field_names = .{
        .replication_instance = "ReplicationInstance",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyReplicationInstanceInput, options: CallOptions) !ModifyReplicationInstanceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dms", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyReplicationInstanceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dms", "Database Migration Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.ModifyReplicationInstance");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyReplicationInstanceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ModifyReplicationInstanceOutput, body, allocator);
}
