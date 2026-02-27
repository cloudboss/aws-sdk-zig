const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DeviceConfiguration = @import("device_configuration.zig").DeviceConfiguration;
const ImpactLevel = @import("impact_level.zig").ImpactLevel;
const JobType = @import("job_type.zig").JobType;
const Notification = @import("notification.zig").Notification;
const OnDeviceServiceConfiguration = @import("on_device_service_configuration.zig").OnDeviceServiceConfiguration;
const PickupDetails = @import("pickup_details.zig").PickupDetails;
const RemoteManagement = @import("remote_management.zig").RemoteManagement;
const JobResource = @import("job_resource.zig").JobResource;
const ShippingOption = @import("shipping_option.zig").ShippingOption;
const SnowballCapacity = @import("snowball_capacity.zig").SnowballCapacity;
const SnowballType = @import("snowball_type.zig").SnowballType;
const TaxDocuments = @import("tax_documents.zig").TaxDocuments;

pub const CreateJobInput = struct {
    /// The ID for the address that you want the Snow device shipped to.
    address_id: ?[]const u8 = null,

    /// The ID of a cluster. If you're creating a job for a node in a cluster, you
    /// need to
    /// provide only this `clusterId` value. The other job attributes are inherited
    /// from
    /// the cluster.
    cluster_id: ?[]const u8 = null,

    /// Defines an optional description of this specific job, for example `Important
    /// Photos 2016-08-11`.
    description: ?[]const u8 = null,

    /// Defines the device configuration for an Snowball Edge job.
    ///
    /// For more information, see
    /// "https://docs.aws.amazon.com/snowball/latest/snowcone-guide/snow-device-types.html" (Snow
    /// Family Devices and Capacity) in the *Snowcone User Guide* or
    /// "https://docs.aws.amazon.com/snowball/latest/developer-guide/snow-device-types.html" (Snow
    /// Family Devices and Capacity) in the *Snowcone User Guide*.
    device_configuration: ?DeviceConfiguration = null,

    /// The forwarding address ID for a job. This field is not supported in most
    /// Regions.
    forwarding_address_id: ?[]const u8 = null,

    /// The highest impact level of data that will be stored or processed on the
    /// device, provided at job creation.
    impact_level: ?ImpactLevel = null,

    /// Defines the type of job that you're creating.
    job_type: ?JobType = null,

    /// The `KmsKeyARN` that you want to associate with this job.
    /// `KmsKeyARN`s are created using the
    /// [CreateKey](https://docs.aws.amazon.com/kms/latest/APIReference/API_CreateKey.html)
    /// Key Management Service (KMS) API action.
    kms_key_arn: ?[]const u8 = null,

    /// The ID of the long-term pricing type for the device.
    long_term_pricing_id: ?[]const u8 = null,

    /// Defines the Amazon Simple Notification Service (Amazon SNS) notification
    /// settings for
    /// this job.
    notification: ?Notification = null,

    /// Specifies the service or services on the Snow Family device that your
    /// transferred data
    /// will be exported from or imported into. Amazon Web Services Snow Family
    /// supports Amazon S3 and NFS (Network File
    /// System) and the Amazon Web Services Storage Gateway service Tape Gateway
    /// type.
    on_device_service_configuration: ?OnDeviceServiceConfiguration = null,

    /// Information identifying the person picking up the device.
    pickup_details: ?PickupDetails = null,

    /// Allows you to securely operate and manage Snowcone devices remotely from
    /// outside of your
    /// internal network. When set to `INSTALLED_AUTOSTART`, remote management will
    /// automatically be available when the device arrives at your location.
    /// Otherwise, you need to
    /// use the Snowball Edge client to manage the device. When set to
    /// `NOT_INSTALLED`, remote management will not be available on the device.
    remote_management: ?RemoteManagement = null,

    /// Defines the Amazon S3 buckets associated with this job.
    ///
    /// With `IMPORT` jobs, you specify the bucket or buckets that your transferred
    /// data will be imported into.
    ///
    /// With `EXPORT` jobs, you specify the bucket or buckets that your transferred
    /// data will be exported from. Optionally, you can also specify a `KeyRange`
    /// value. If
    /// you choose to export a range, you define the length of the range by
    /// providing either an
    /// inclusive `BeginMarker` value, an inclusive `EndMarker` value, or both.
    /// Ranges are UTF-8 binary sorted.
    resources: ?JobResource = null,

    /// The `RoleARN` that you want to associate with this job.
    /// `RoleArn`s are created using the
    /// [CreateRole](https://docs.aws.amazon.com/IAM/latest/APIReference/API_CreateRole.html)
    /// Identity and Access Management (IAM) API action.
    role_arn: ?[]const u8 = null,

    /// The shipping speed for this job. This speed doesn't dictate how soon you'll
    /// get the
    /// Snow device, rather it represents how quickly the Snow device moves to its
    /// destination while
    /// in transit. Regional shipping speeds are as follows:
    ///
    /// * In Australia, you have access to express shipping. Typically, Snow devices
    ///   shipped
    /// express are delivered in about a day.
    ///
    /// * In the European Union (EU), you have access to express shipping.
    ///   Typically, Snow
    /// devices shipped express are delivered in about a day. In addition, most
    /// countries in the
    /// EU have access to standard shipping, which typically takes less than a week,
    /// one
    /// way.
    ///
    /// * In India, Snow devices are delivered in one to seven days.
    ///
    /// * In the US, you have access to one-day shipping and two-day shipping.
    shipping_option: ?ShippingOption = null,

    /// If your job is being created in one of the US regions, you have the option
    /// of
    /// specifying what size Snow device you'd like for this job. In all other
    /// regions, Snowballs come
    /// with 80 TB in storage capacity.
    ///
    /// For more information, see
    /// "https://docs.aws.amazon.com/snowball/latest/snowcone-guide/snow-device-types.html" (Snow
    /// Family Devices and Capacity) in the *Snowcone User Guide* or
    /// "https://docs.aws.amazon.com/snowball/latest/developer-guide/snow-device-types.html" (Snow
    /// Family Devices and Capacity) in the *Snowcone User Guide*.
    snowball_capacity_preference: ?SnowballCapacity = null,

    /// The type of Snow Family devices to use for this job.
    ///
    /// For cluster jobs, Amazon Web Services Snow Family currently supports only
    /// the
    /// `EDGE` device type.
    ///
    /// The type of Amazon Web Services Snow device to use for this job. Currently,
    /// the only
    /// supported device type for cluster jobs is `EDGE`.
    ///
    /// For more information, see [Snowball Edge Device
    /// Options](https://docs.aws.amazon.com/snowball/latest/developer-guide/device-differences.html) in the Snowball Edge Developer Guide.
    ///
    /// For more information, see
    /// "https://docs.aws.amazon.com/snowball/latest/snowcone-guide/snow-device-types.html" (Snow
    /// Family Devices and Capacity) in the *Snowcone User Guide* or
    /// "https://docs.aws.amazon.com/snowball/latest/developer-guide/snow-device-types.html" (Snow
    /// Family Devices and Capacity) in the *Snowcone User Guide*.
    snowball_type: ?SnowballType = null,

    /// The tax documents required in your Amazon Web Services Region.
    tax_documents: ?TaxDocuments = null,

    pub const json_field_names = .{
        .address_id = "AddressId",
        .cluster_id = "ClusterId",
        .description = "Description",
        .device_configuration = "DeviceConfiguration",
        .forwarding_address_id = "ForwardingAddressId",
        .impact_level = "ImpactLevel",
        .job_type = "JobType",
        .kms_key_arn = "KmsKeyARN",
        .long_term_pricing_id = "LongTermPricingId",
        .notification = "Notification",
        .on_device_service_configuration = "OnDeviceServiceConfiguration",
        .pickup_details = "PickupDetails",
        .remote_management = "RemoteManagement",
        .resources = "Resources",
        .role_arn = "RoleARN",
        .shipping_option = "ShippingOption",
        .snowball_capacity_preference = "SnowballCapacityPreference",
        .snowball_type = "SnowballType",
        .tax_documents = "TaxDocuments",
    };
};

pub const CreateJobOutput = struct {
    /// The automatically generated ID for a job, for example
    /// `JID123e4567-e89b-12d3-a456-426655440000`.
    job_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_id = "JobId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateJobInput, options: Options) !CreateJobOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: CreateJobInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(alloc, "X-Amz-Target", "AWSIESnowballJobManagementService.CreateJob");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateJobOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateJobOutput, body, alloc);
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
