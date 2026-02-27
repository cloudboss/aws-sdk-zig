const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const GatewayCapacity = @import("gateway_capacity.zig").GatewayCapacity;
const NetworkInterface = @import("network_interface.zig").NetworkInterface;
const HostEnvironment = @import("host_environment.zig").HostEnvironment;
const Tag = @import("tag.zig").Tag;

pub const DescribeGatewayInformationInput = struct {
    gateway_arn: []const u8,

    pub const json_field_names = .{
        .gateway_arn = "GatewayARN",
    };
};

pub const DescribeGatewayInformationOutput = struct {
    /// The Amazon Resource Name (ARN) of the Amazon CloudWatch log group that is
    /// used to
    /// monitor events in the gateway. This field only only exist and returns once
    /// it have been
    /// chosen and set by the SGW service, based on the OS version of the gateway VM
    cloud_watch_log_group_arn: ?[]const u8 = null,

    /// Date after which this gateway will not receive software updates for new
    /// features and bug
    /// fixes.
    deprecation_date: ?[]const u8 = null,

    /// The ID of the Amazon EC2 instance that was used to launch the gateway.
    ec_2_instance_id: ?[]const u8 = null,

    /// The Amazon Web Services Region where the Amazon EC2 instance is located.
    ec_2_instance_region: ?[]const u8 = null,

    /// The type of endpoint for your gateway.
    ///
    /// Valid Values: `STANDARD` | `FIPS`
    endpoint_type: ?[]const u8 = null,

    gateway_arn: ?[]const u8 = null,

    /// Specifies the size of the gateway's metadata cache.
    gateway_capacity: ?GatewayCapacity = null,

    /// The unique identifier assigned to your gateway during activation. This ID
    /// becomes part
    /// of the gateway Amazon Resource Name (ARN), which you use as input for other
    /// operations.
    gateway_id: ?[]const u8 = null,

    /// The name you configured for your gateway.
    gateway_name: ?[]const u8 = null,

    /// A NetworkInterface array that contains descriptions of the gateway
    /// network interfaces.
    gateway_network_interfaces: ?[]const NetworkInterface = null,

    /// A value that indicates the operating state of the gateway.
    gateway_state: ?[]const u8 = null,

    /// A value that indicates the time zone configured for the gateway.
    gateway_timezone: ?[]const u8 = null,

    /// The type of the gateway.
    ///
    /// Amazon FSx File Gateway is no longer available to new customers. Existing
    /// customers of FSx File Gateway can continue to use the service normally. For
    /// capabilities similar to FSx File Gateway, visit [this blog
    /// post](https://aws.amazon.com/blogs/storage/switch-your-file-share-access-from-amazon-fsx-file-gateway-to-amazon-fsx-for-windows-file-server/).
    gateway_type: ?[]const u8 = null,

    /// The type of hardware or software platform on which the gateway is running.
    ///
    /// Tape Gateway is no longer available on Snow Family devices.
    host_environment: ?HostEnvironment = null,

    /// A unique identifier for the specific instance of the host platform running
    /// the gateway.
    /// This value is only available for certain host environments, and its format
    /// depends on the
    /// host environment type.
    host_environment_id: ?[]const u8 = null,

    /// The date on which the last software update was applied to the gateway. If
    /// the gateway
    /// has never been updated, this field does not return a value in the response.
    /// This only only
    /// exist and returns once it have been chosen and set by the SGW service, based
    /// on the OS
    /// version of the gateway VM
    last_software_update: ?[]const u8 = null,

    /// The date on which an update to the gateway is available. This date is in the
    /// time zone
    /// of the gateway. If the gateway is not available for an update this field is
    /// not returned in
    /// the response.
    next_update_availability_date: ?[]const u8 = null,

    /// Date after which this gateway will not receive software updates for new
    /// features.
    software_updates_end_date: ?[]const u8 = null,

    /// The version number of the software running on the gateway appliance.
    software_version: ?[]const u8 = null,

    /// A list of the metadata cache sizes that the gateway can support based on its
    /// current
    /// hardware specifications.
    supported_gateway_capacities: ?[]const GatewayCapacity = null,

    /// A list of up to 50 tags assigned to the gateway, sorted alphabetically by
    /// key name. Each
    /// tag is a key-value pair. For a gateway with more than 10 tags assigned, you
    /// can view all
    /// tags using the `ListTagsForResource` API operation.
    tags: ?[]const Tag = null,

    /// The configuration settings for the virtual private cloud (VPC) endpoint for
    /// your
    /// gateway.
    vpc_endpoint: ?[]const u8 = null,

    pub const json_field_names = .{
        .cloud_watch_log_group_arn = "CloudWatchLogGroupARN",
        .deprecation_date = "DeprecationDate",
        .ec_2_instance_id = "Ec2InstanceId",
        .ec_2_instance_region = "Ec2InstanceRegion",
        .endpoint_type = "EndpointType",
        .gateway_arn = "GatewayARN",
        .gateway_capacity = "GatewayCapacity",
        .gateway_id = "GatewayId",
        .gateway_name = "GatewayName",
        .gateway_network_interfaces = "GatewayNetworkInterfaces",
        .gateway_state = "GatewayState",
        .gateway_timezone = "GatewayTimezone",
        .gateway_type = "GatewayType",
        .host_environment = "HostEnvironment",
        .host_environment_id = "HostEnvironmentId",
        .last_software_update = "LastSoftwareUpdate",
        .next_update_availability_date = "NextUpdateAvailabilityDate",
        .software_updates_end_date = "SoftwareUpdatesEndDate",
        .software_version = "SoftwareVersion",
        .supported_gateway_capacities = "SupportedGatewayCapacities",
        .tags = "Tags",
        .vpc_endpoint = "VPCEndpoint",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeGatewayInformationInput, options: Options) !DescribeGatewayInformationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "storagegateway");

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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeGatewayInformationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("storagegateway", "Storage Gateway", alloc);

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
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "StorageGateway_20130630.DescribeGatewayInformation");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeGatewayInformationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeGatewayInformationOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidGatewayRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_gateway_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableError")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_error = .{
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
