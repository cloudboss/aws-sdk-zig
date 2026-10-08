const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Notification = @import("notification.zig").Notification;
const OnDeviceServiceConfiguration = @import("on_device_service_configuration.zig").OnDeviceServiceConfiguration;
const PickupDetails = @import("pickup_details.zig").PickupDetails;
const JobResource = @import("job_resource.zig").JobResource;
const ShippingOption = @import("shipping_option.zig").ShippingOption;
const SnowballCapacity = @import("snowball_capacity.zig").SnowballCapacity;

pub const UpdateJobInput = struct {
    /// The ID of the updated Address object.
    address_id: ?[]const u8 = null,

    /// The updated description of this job's JobMetadata object.
    description: ?[]const u8 = null,

    /// The updated ID for the forwarding address for a job. This field is not
    /// supported in most regions.
    forwarding_address_id: ?[]const u8 = null,

    /// The job ID of the job that you want to update, for example
    /// `JID123e4567-e89b-12d3-a456-426655440000`.
    job_id: []const u8,

    /// The new or updated Notification object.
    notification: ?Notification = null,

    /// Specifies the service or services on the Snow Family device that your
    /// transferred data
    /// will be exported from or imported into. Amazon Web Services Snow Family
    /// supports Amazon S3 and NFS (Network File
    /// System) and the Amazon Web Services Storage Gateway service Tape Gateway
    /// type.
    on_device_service_configuration: ?OnDeviceServiceConfiguration = null,

    pickup_details: ?PickupDetails = null,

    /// The updated `JobResource` object, or the updated JobResource object.
    resources: ?JobResource = null,

    /// The new role Amazon Resource Name (ARN) that you want to associate with this
    /// job. To
    /// create a role ARN, use the
    /// [CreateRole](https://docs.aws.amazon.com/IAM/latest/APIReference/API_CreateRole.html)Identity and Access Management
    /// (IAM) API action.
    role_arn: ?[]const u8 = null,

    /// The updated shipping option value of this job's ShippingDetails
    /// object.
    shipping_option: ?ShippingOption = null,

    /// The updated `SnowballCapacityPreference` of this job's JobMetadata object.
    /// The 50 TB Snowballs are only available in the US
    /// regions.
    ///
    /// For more information, see
    /// "https://docs.aws.amazon.com/snowball/latest/snowcone-guide/snow-device-types.html" (Snow
    /// Family Devices and Capacity) in the *Snowcone User Guide* or
    /// "https://docs.aws.amazon.com/snowball/latest/developer-guide/snow-device-types.html" (Snow
    /// Family Devices and Capacity) in the *Snowcone User Guide*.
    snowball_capacity_preference: ?SnowballCapacity = null,

    pub const json_field_names = .{
        .address_id = "AddressId",
        .description = "Description",
        .forwarding_address_id = "ForwardingAddressId",
        .job_id = "JobId",
        .notification = "Notification",
        .on_device_service_configuration = "OnDeviceServiceConfiguration",
        .pickup_details = "PickupDetails",
        .resources = "Resources",
        .role_arn = "RoleARN",
        .shipping_option = "ShippingOption",
        .snowball_capacity_preference = "SnowballCapacityPreference",
    };
};

pub const UpdateJobOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateJobInput, options: CallOptions) !UpdateJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSIESnowballJobManagementService.UpdateJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateJobOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
