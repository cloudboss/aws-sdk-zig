const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ConnectivityInfo = @import("connectivity_info.zig").ConnectivityInfo;
const HostInfoForCreate = @import("host_info_for_create.zig").HostInfoForCreate;
const InitialVlans = @import("initial_vlans.zig").InitialVlans;
const LicenseInfo = @import("license_info.zig").LicenseInfo;
const ServiceAccessSecurityGroups = @import("service_access_security_groups.zig").ServiceAccessSecurityGroups;
const VcfHostnames = @import("vcf_hostnames.zig").VcfHostnames;
const VcfVersion = @import("vcf_version.zig").VcfVersion;
const Environment = @import("environment.zig").Environment;

pub const CreateEnvironmentInput = struct {
    /// This parameter is not used in Amazon EVS currently. If you supply input for
    /// this parameter, it will have no effect.
    ///
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the environment creation request. If you do not specify a
    /// client token, a randomly generated token is used for the request to ensure
    /// idempotency.
    client_token: ?[]const u8 = null,

    /// The connectivity configuration for the environment. Amazon EVS requires that
    /// you specify two route server peer IDs. During environment creation, the
    /// route server endpoints peer with the NSX edges over the NSX uplink subnet,
    /// providing BGP-based dynamic routing for overlay networks.
    connectivity_info: ConnectivityInfo,

    /// The name to give to your environment. The name can contain only alphanumeric
    /// characters (case-sensitive), hyphens, and underscores. It must start with an
    /// alphanumeric character, and can't be longer than 100 characters. The name
    /// must be unique within the Amazon Web Services Region and Amazon Web Services
    /// account that you're creating the environment in.
    environment_name: ?[]const u8 = null,

    /// The ESX hosts to add to the environment. Amazon EVS requires that you
    /// provide details for a minimum of 4 hosts during environment creation.
    ///
    /// For each host, you must provide the desired hostname, EC2 SSH keypair name,
    /// and EC2 instance type. Optionally, you can also provide a partition or
    /// cluster placement group to use, or use Amazon EC2 Dedicated Hosts.
    hosts: []const HostInfoForCreate,

    /// The initial VLAN subnets for the Amazon EVS environment.
    ///
    /// For each Amazon EVS VLAN subnet, you must specify a non-overlapping CIDR
    /// block. Amazon EVS VLAN subnets have a minimum CIDR block size of /28 and a
    /// maximum size of /24.
    initial_vlans: InitialVlans,

    /// A unique ID for the customer-managed KMS key that is used to encrypt the VCF
    /// credential pairs for SDDC Manager, NSX Manager, and vCenter appliances.
    /// These credentials are stored in Amazon Web Services Secrets Manager.
    kms_key_id: ?[]const u8 = null,

    /// The license information that Amazon EVS requires to create an environment.
    /// Amazon EVS requires two license keys: a VCF solution key and a vSAN license
    /// key. The VCF solution key must cover a minimum of 256 cores. The vSAN
    /// license key must provide at least 110 TiB of vSAN capacity.
    ///
    /// VCF licenses can be used for only one Amazon EVS environment. Amazon EVS
    /// does not support reuse of VCF licenses for multiple environments.
    ///
    /// VCF license information can be retrieved from the Broadcom portal.
    license_info: []const LicenseInfo,

    /// The security group that controls communication between the Amazon EVS
    /// control plane and VPC. The default security group is used if a custom
    /// security group isn't specified.
    ///
    /// The security group should allow access to the following.
    ///
    /// * TCP/UDP access to the DNS servers
    /// * HTTPS/SSH access to the host management VLAN subnet
    /// * HTTPS/SSH access to the Management VM VLAN subnet
    ///
    /// You should avoid modifying the security group rules after deployment, as
    /// this can break the persistent connection between the Amazon EVS control
    /// plane and VPC. This can cause future environment actions like adding or
    /// removing hosts to fail.
    service_access_security_groups: ?ServiceAccessSecurityGroups = null,

    /// The subnet that is used to establish connectivity between the Amazon EVS
    /// control plane and VPC. Amazon EVS uses this subnet to validate mandatory DNS
    /// records for your VCF appliances and hosts and create the environment.
    service_access_subnet_id: []const u8,

    /// The Broadcom Site ID that is allocated to you as part of your electronic
    /// software delivery. This ID allows customer access to the Broadcom portal,
    /// and is provided to you by Broadcom at the close of your software contract or
    /// contract renewal. Amazon EVS uses the Broadcom Site ID that you provide to
    /// meet Broadcom VCF license usage reporting requirements for Amazon EVS.
    site_id: []const u8,

    /// Metadata that assists with categorization and organization. Each tag
    /// consists of a key and an optional value. You define both. Tags don't
    /// propagate to any other cluster or Amazon Web Services resources.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Customer confirmation that the customer has purchased and will continue to
    /// maintain the required number of VCF software licenses to cover all physical
    /// processor cores in the Amazon EVS environment. Information about your VCF
    /// software in Amazon EVS will be shared with Broadcom to verify license
    /// compliance. Amazon EVS does not validate license keys. To validate license
    /// keys, visit the Broadcom support portal.
    terms_accepted: bool,

    /// The DNS hostnames for the virtual machines that host the VCF management
    /// appliances. Amazon EVS requires that you provide DNS hostnames for the
    /// following appliances: vCenter, NSX Manager, SDDC Manager, and Cloud Builder.
    vcf_hostnames: VcfHostnames,

    /// The VCF version to use for the environment.
    vcf_version: VcfVersion,

    /// A unique ID for the VPC that the environment is deployed inside.
    ///
    /// Amazon EVS requires that all VPC subnets exist in a single Availability Zone
    /// in a Region where the service is available.
    ///
    /// The VPC that you specify must have a valid DHCP option set with domain name,
    /// at least two DNS servers, and an NTP server. These settings are used to
    /// configure your VCF appliances and hosts. The VPC cannot be used with any
    /// other deployed Amazon EVS environment. Amazon EVS does not provide multi-VPC
    /// support for environments at this time.
    ///
    /// Amazon EVS does not support the following Amazon Web Services networking
    /// options for NSX overlay connectivity: cross-Region VPC peering, Amazon S3
    /// gateway endpoints, or Amazon Web Services Direct Connect virtual private
    /// gateway associations.
    ///
    /// Ensure that you specify a VPC that is adequately sized to accommodate the
    /// Amazon EVS subnets.
    vpc_id: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .connectivity_info = "connectivityInfo",
        .environment_name = "environmentName",
        .hosts = "hosts",
        .initial_vlans = "initialVlans",
        .kms_key_id = "kmsKeyId",
        .license_info = "licenseInfo",
        .service_access_security_groups = "serviceAccessSecurityGroups",
        .service_access_subnet_id = "serviceAccessSubnetId",
        .site_id = "siteId",
        .tags = "tags",
        .terms_accepted = "termsAccepted",
        .vcf_hostnames = "vcfHostnames",
        .vcf_version = "vcfVersion",
        .vpc_id = "vpcId",
    };
};

pub const CreateEnvironmentOutput = struct {
    /// A description of the created environment.
    environment: ?Environment = null,

    pub const json_field_names = .{
        .environment = "environment",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEnvironmentInput, options: Options) !CreateEnvironmentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "evs");

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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateEnvironmentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("evs", "evs", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(alloc, "X-Amz-Target", "AmazonElasticVMwareService.CreateEnvironment");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateEnvironmentOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateEnvironmentOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
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
    if (std.mem.eql(u8, error_code, "TagPolicyException")) {
        return .{ .arena = arena, .kind = .{ .tag_policy_exception = .{
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
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
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
