const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Notification = @import("notification.zig").Notification;
const OnDeviceServiceConfiguration = @import("on_device_service_configuration.zig").OnDeviceServiceConfiguration;
const JobResource = @import("job_resource.zig").JobResource;
const ShippingOption = @import("shipping_option.zig").ShippingOption;

pub const UpdateClusterInput = struct {
    /// The ID of the updated Address object.
    address_id: ?[]const u8 = null,

    /// The cluster ID of the cluster that you want to update, for example
    /// `CID123e4567-e89b-12d3-a456-426655440000`.
    cluster_id: []const u8,

    /// The updated description of this cluster.
    description: ?[]const u8 = null,

    /// The updated ID for the forwarding address for a cluster. This field is not
    /// supported in most regions.
    forwarding_address_id: ?[]const u8 = null,

    /// The new or updated Notification object.
    notification: ?Notification = null,

    /// Specifies the service or services on the Snow Family device that your
    /// transferred data
    /// will be exported from or imported into. Amazon Web Services Snow Family
    /// device clusters support Amazon S3 and NFS
    /// (Network File System).
    on_device_service_configuration: ?OnDeviceServiceConfiguration = null,

    /// The updated arrays of JobResource objects that can include updated
    /// S3Resource objects or LambdaResource objects.
    resources: ?JobResource = null,

    /// The new role Amazon Resource Name (ARN) that you want to associate with this
    /// cluster.
    /// To create a role ARN, use the
    /// [CreateRole](https://docs.aws.amazon.com/IAM/latest/APIReference/API_CreateRole.html) API action in Identity and Access Management (IAM).
    role_arn: ?[]const u8 = null,

    /// The updated shipping option value of this cluster's ShippingDetails
    /// object.
    shipping_option: ?ShippingOption = null,

    pub const json_field_names = .{
        .address_id = "AddressId",
        .cluster_id = "ClusterId",
        .description = "Description",
        .forwarding_address_id = "ForwardingAddressId",
        .notification = "Notification",
        .on_device_service_configuration = "OnDeviceServiceConfiguration",
        .resources = "Resources",
        .role_arn = "RoleARN",
        .shipping_option = "ShippingOption",
    };
};

pub const UpdateClusterOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateClusterInput, options: CallOptions) !UpdateClusterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "snowball", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateClusterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("snowball", "Snowball", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSIESnowballJobManagementService.UpdateCluster");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateClusterOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
