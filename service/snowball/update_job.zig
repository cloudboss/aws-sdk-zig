const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateJobInput, options: Options) !UpdateJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "snowball");

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

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("snowball", "Snowball", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "AWSIESnowballJobManagementService.UpdateJob");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateJobOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = alloc;
    return .{};
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

    if (std.mem.eql(u8, error_code, "ClusterLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .cluster_limit_exceeded_exception = .{
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
    if (std.mem.eql(u8, error_code, "Ec2RequestFailedException")) {
        return .{ .arena = arena, .kind = .{ .ec_2_request_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAddressException")) {
        return .{ .arena = arena, .kind = .{ .invalid_address_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInputCombinationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_input_combination_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidJobStateException")) {
        return .{ .arena = arena, .kind = .{ .invalid_job_state_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidResourceException")) {
        return .{ .arena = arena, .kind = .{ .invalid_resource_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "KMSRequestFailedException")) {
        return .{ .arena = arena, .kind = .{ .kms_request_failed_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReturnShippingLabelAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .return_shipping_label_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedAddressException")) {
        return .{ .arena = arena, .kind = .{ .unsupported_address_exception = .{
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
