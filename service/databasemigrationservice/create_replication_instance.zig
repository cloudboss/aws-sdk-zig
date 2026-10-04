const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const KerberosAuthenticationSettings = @import("kerberos_authentication_settings.zig").KerberosAuthenticationSettings;
const Tag = @import("tag.zig").Tag;
const ReplicationInstance = @import("replication_instance.zig").ReplicationInstance;

pub const CreateReplicationInstanceInput = struct {
    /// The amount of storage (in gigabytes) to be initially allocated for the
    /// replication
    /// instance.
    allocated_storage: ?i32 = null,

    /// A value that indicates whether minor engine upgrades are applied
    /// automatically to the
    /// replication instance during the maintenance window. This parameter defaults
    /// to
    /// `true`.
    ///
    /// Default: `true`
    auto_minor_version_upgrade: ?bool = null,

    /// The Availability Zone where the replication instance will be created. The
    /// default value
    /// is a random, system-chosen Availability Zone in the endpoint's Amazon Web
    /// Services Region, for example:
    /// `us-east-1d`.
    availability_zone: ?[]const u8 = null,

    /// A list of custom DNS name servers supported for the replication instance to
    /// access your
    /// on-premise source or target database. This list overrides the default name
    /// servers
    /// supported by the replication instance. You can specify a comma-separated
    /// list of internet
    /// addresses for up to four on-premise DNS name servers. For example:
    /// `"1.1.1.1,2.2.2.2,3.3.3.3,4.4.4.4"`
    dns_name_servers: ?[]const u8 = null,

    /// The engine version number of the replication instance.
    ///
    /// If an engine version number is not specified when a replication instance is
    /// created, the
    /// default is the latest engine version available.
    engine_version: ?[]const u8 = null,

    /// Specifies the settings required for kerberos authentication when creating
    /// the
    /// replication instance.
    kerberos_authentication_settings: ?KerberosAuthenticationSettings = null,

    /// An KMS key identifier that is used to encrypt the data on the replication
    /// instance.
    ///
    /// If you don't specify a value for the `KmsKeyId` parameter, then DMS uses
    /// your default encryption key.
    ///
    /// KMS creates the default encryption key for your Amazon Web Services account.
    /// Your Amazon Web Services account has
    /// a different default encryption key for each Amazon Web Services Region.
    kms_key_id: ?[]const u8 = null,

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

    /// The weekly time range during which system maintenance can occur, in
    /// Universal
    /// Coordinated Time (UTC).
    ///
    /// Format: `ddd:hh24:mi-ddd:hh24:mi`
    ///
    /// Default: A 30-minute window selected at random from an 8-hour block of time
    /// per
    /// Amazon Web Services Region, occurring on a random day of the week.
    ///
    /// Valid Days: Mon, Tue, Wed, Thu, Fri, Sat, Sun
    ///
    /// Constraints: Minimum 30-minute window.
    preferred_maintenance_window: ?[]const u8 = null,

    /// Specifies the accessibility options for the replication instance. A value of
    /// `true` represents an instance with a public IP address. A value of
    /// `false` represents an instance with a private IP address. The default value
    /// is `true`.
    publicly_accessible: ?bool = null,

    /// The compute and memory capacity of the replication instance as defined for
    /// the specified
    /// replication instance class. For example to specify the instance class
    /// dms.c4.large, set
    /// this parameter to `"dms.c4.large"`.
    ///
    /// For more information on the settings and capacities for the available
    /// replication
    /// instance classes, see [
    /// Choosing the right DMS replication
    /// instance](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_ReplicationInstance.Types.html ); and, [Selecting the best size for a replication instance](https://docs.aws.amazon.com/dms/latest/userguide/CHAP_BestPractices.SizingReplicationInstance.html).
    replication_instance_class: []const u8,

    /// The replication instance identifier. This parameter is stored as a lowercase
    /// string.
    ///
    /// Constraints:
    ///
    /// * Must contain 1-63 alphanumeric characters or hyphens.
    ///
    /// * First character must be a letter.
    ///
    /// * Can't end with a hyphen or contain two consecutive hyphens.
    ///
    /// Example: `myrepinstance`
    replication_instance_identifier: []const u8,

    /// A subnet group to associate with the replication instance.
    replication_subnet_group_identifier: ?[]const u8 = null,

    /// A friendly name for the resource identifier at the end of the `EndpointArn`
    /// response parameter that is returned in the created `Endpoint` object. The
    /// value
    /// for this parameter can have up to 31 characters. It can contain only ASCII
    /// letters, digits,
    /// and hyphen ('-'). Also, it can't end with a hyphen or contain two
    /// consecutive hyphens,
    /// and can only begin with a letter, such as `Example-App-ARN1`. For example,
    /// this
    /// value might result in the `EndpointArn` value
    /// `arn:aws:dms:eu-west-1:012345678901:rep:Example-App-ARN1`. If you don't
    /// specify a `ResourceIdentifier` value, DMS generates a default identifier
    /// value
    /// for the end of `EndpointArn`.
    resource_identifier: ?[]const u8 = null,

    /// One or more tags to be assigned to the replication instance.
    tags: ?[]const Tag = null,

    /// Specifies the VPC security group to be used with the replication instance.
    /// The VPC
    /// security group must work with the VPC containing the replication instance.
    vpc_security_group_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .allocated_storage = "AllocatedStorage",
        .auto_minor_version_upgrade = "AutoMinorVersionUpgrade",
        .availability_zone = "AvailabilityZone",
        .dns_name_servers = "DnsNameServers",
        .engine_version = "EngineVersion",
        .kerberos_authentication_settings = "KerberosAuthenticationSettings",
        .kms_key_id = "KmsKeyId",
        .multi_az = "MultiAZ",
        .network_type = "NetworkType",
        .preferred_maintenance_window = "PreferredMaintenanceWindow",
        .publicly_accessible = "PubliclyAccessible",
        .replication_instance_class = "ReplicationInstanceClass",
        .replication_instance_identifier = "ReplicationInstanceIdentifier",
        .replication_subnet_group_identifier = "ReplicationSubnetGroupIdentifier",
        .resource_identifier = "ResourceIdentifier",
        .tags = "Tags",
        .vpc_security_group_ids = "VpcSecurityGroupIds",
    };
};

pub const CreateReplicationInstanceOutput = struct {
    /// The replication instance that was created.
    replication_instance: ?ReplicationInstance = null,

    pub const json_field_names = .{
        .replication_instance = "ReplicationInstance",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateReplicationInstanceInput, options: CallOptions) !CreateReplicationInstanceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateReplicationInstanceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.CreateReplicationInstance");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateReplicationInstanceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateReplicationInstanceOutput, body, allocator);
}
