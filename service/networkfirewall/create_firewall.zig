const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AvailabilityZoneMapping = @import("availability_zone_mapping.zig").AvailabilityZoneMapping;
const EnabledAnalysisType = @import("enabled_analysis_type.zig").EnabledAnalysisType;
const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const SubnetMapping = @import("subnet_mapping.zig").SubnetMapping;
const Tag = @import("tag.zig").Tag;
const Firewall = @import("firewall.zig").Firewall;
const FirewallStatus = @import("firewall_status.zig").FirewallStatus;

pub const CreateFirewallInput = struct {
    /// Optional. A setting indicating whether the firewall is protected against
    /// changes to its Availability Zone configuration. When set to `TRUE`, you
    /// cannot add or remove Availability Zones without first disabling this
    /// protection using UpdateAvailabilityZoneChangeProtection.
    ///
    /// Default value: `FALSE`
    availability_zone_change_protection: ?bool = null,

    /// Required. The Availability Zones where you want to create firewall endpoints
    /// for a transit gateway-attached firewall. You must specify at least one
    /// Availability Zone. Consider enabling the firewall in every Availability Zone
    /// where you have workloads to maintain Availability Zone isolation.
    ///
    /// You can modify Availability Zones later using AssociateAvailabilityZones or
    /// DisassociateAvailabilityZones, but this may briefly disrupt traffic. The
    /// `AvailabilityZoneChangeProtection` setting controls whether you can make
    /// these modifications.
    availability_zone_mappings: ?[]const AvailabilityZoneMapping = null,

    /// A flag indicating whether it is possible to delete the firewall. A setting
    /// of `TRUE` indicates
    /// that the firewall is protected against deletion. Use this setting to protect
    /// against
    /// accidentally deleting a firewall that is in use. When you create a firewall,
    /// the operation initializes this flag to `TRUE`.
    delete_protection: ?bool = null,

    /// A description of the firewall.
    description: ?[]const u8 = null,

    /// An optional setting indicating the specific traffic analysis types to enable
    /// on the firewall.
    enabled_analysis_types: ?[]const EnabledAnalysisType = null,

    /// A complex type that contains settings for encryption of your firewall
    /// resources.
    encryption_configuration: ?EncryptionConfiguration = null,

    /// The descriptive name of the firewall. You can't change the name of a
    /// firewall after you create it.
    firewall_name: []const u8,

    /// The Amazon Resource Name (ARN) of the FirewallPolicy that you want to
    /// use for the firewall.
    firewall_policy_arn: []const u8,

    /// A setting indicating whether the firewall is protected against a change to
    /// the firewall policy association.
    /// Use this setting to protect against
    /// accidentally modifying the firewall policy for a firewall that is in use.
    /// When you create a firewall, the operation initializes this setting to
    /// `TRUE`.
    firewall_policy_change_protection: ?bool = null,

    /// A setting indicating whether the firewall is protected against changes to
    /// the subnet associations.
    /// Use this setting to protect against
    /// accidentally modifying the subnet associations for a firewall that is in
    /// use. When you create a firewall, the operation initializes this setting to
    /// `TRUE`.
    subnet_change_protection: ?bool = null,

    /// The public subnets to use for your Network Firewall firewalls. Each subnet
    /// must belong to a
    /// different Availability Zone in the VPC. Network Firewall creates a firewall
    /// endpoint in each
    /// subnet.
    subnet_mappings: ?[]const SubnetMapping = null,

    /// The key:value pairs to associate with the resource.
    tags: ?[]const Tag = null,

    /// Required when creating a transit gateway-attached firewall. The unique
    /// identifier of the transit gateway to attach to this firewall. You can
    /// provide either a transit gateway from your account or one that has been
    /// shared with you through Resource Access Manager.
    ///
    /// After creating the firewall, you cannot change the transit gateway
    /// association. To use a different transit gateway, you must create a new
    /// firewall.
    ///
    /// For information about creating firewalls, see CreateFirewall. For specific
    /// guidance about transit gateway-attached firewalls, see [Considerations for
    /// transit gateway-attached
    /// firewalls](https://docs.aws.amazon.com/network-firewall/latest/developerguide/tgw-firewall-considerations.html) in the *Network Firewall Developer Guide*.
    transit_gateway_id: ?[]const u8 = null,

    /// The unique identifier of the VPC where Network Firewall should create the
    /// firewall.
    ///
    /// You can't change this setting after you create the firewall.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .availability_zone_change_protection = "AvailabilityZoneChangeProtection",
        .availability_zone_mappings = "AvailabilityZoneMappings",
        .delete_protection = "DeleteProtection",
        .description = "Description",
        .enabled_analysis_types = "EnabledAnalysisTypes",
        .encryption_configuration = "EncryptionConfiguration",
        .firewall_name = "FirewallName",
        .firewall_policy_arn = "FirewallPolicyArn",
        .firewall_policy_change_protection = "FirewallPolicyChangeProtection",
        .subnet_change_protection = "SubnetChangeProtection",
        .subnet_mappings = "SubnetMappings",
        .tags = "Tags",
        .transit_gateway_id = "TransitGatewayId",
        .vpc_id = "VpcId",
    };
};

pub const CreateFirewallOutput = struct {
    /// The configuration settings for the firewall. These settings include the
    /// firewall policy and the subnets in your VPC to use for the firewall
    /// endpoints.
    firewall: ?Firewall = null,

    /// Detailed information about the current status of a Firewall. You can
    /// retrieve this for a firewall by calling DescribeFirewall and providing the
    /// firewall name and ARN.
    ///
    /// The firewall status indicates a combined status. It indicates whether all
    /// subnets are up-to-date with the latest firewall configurations, which is
    /// based on the sync states config values, and also whether all subnets have
    /// their endpoints fully enabled, based on their sync states attachment values.
    firewall_status: ?FirewallStatus = null,

    pub const json_field_names = .{
        .firewall = "Firewall",
        .firewall_status = "FirewallStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFirewallInput, options: CallOptions) !CreateFirewallOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "networkfirewall");

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFirewallInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("networkfirewall", "Network Firewall", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "NetworkFirewall_20201112.CreateFirewall");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFirewallOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateFirewallOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "InsufficientCapacityException")) {
        return .{ .arena = arena, .kind = .{ .insufficient_capacity_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidOperationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_operation_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidResourcePolicyException")) {
        return .{ .arena = arena, .kind = .{ .invalid_resource_policy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_token_exception = .{
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
    if (std.mem.eql(u8, error_code, "LogDestinationPermissionException")) {
        return .{ .arena = arena, .kind = .{ .log_destination_permission_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceOwnerCheckException")) {
        return .{ .arena = arena, .kind = .{ .resource_owner_check_exception = .{
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
    if (std.mem.eql(u8, error_code, "UnsupportedOperationException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_operation_exception = .{
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
