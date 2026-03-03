const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const JobType = @import("job_type.zig").JobType;
const Notification = @import("notification.zig").Notification;
const OnDeviceServiceConfiguration = @import("on_device_service_configuration.zig").OnDeviceServiceConfiguration;
const RemoteManagement = @import("remote_management.zig").RemoteManagement;
const JobResource = @import("job_resource.zig").JobResource;
const ShippingOption = @import("shipping_option.zig").ShippingOption;
const SnowballCapacity = @import("snowball_capacity.zig").SnowballCapacity;
const SnowballType = @import("snowball_type.zig").SnowballType;
const TaxDocuments = @import("tax_documents.zig").TaxDocuments;
const JobListEntry = @import("job_list_entry.zig").JobListEntry;

pub const CreateClusterInput = struct {
    /// The ID for the address that you want the cluster shipped to.
    address_id: []const u8,

    /// An optional description of this specific cluster, for example `Environmental
    /// Data
    /// Cluster-01`.
    description: ?[]const u8 = null,

    /// Force to create cluster when user attempts to overprovision or
    /// underprovision a cluster. A cluster is overprovisioned or underprovisioned
    /// if the initial size of the cluster is more (overprovisioned) or less
    /// (underprovisioned) than what
    /// needed to meet capacity requirement specified with
    /// `OnDeviceServiceConfiguration`.
    force_create_jobs: ?bool = null,

    /// The forwarding address ID for a cluster. This field is not supported in most
    /// regions.
    forwarding_address_id: ?[]const u8 = null,

    /// If provided, each job will be automatically created and associated with the
    /// new cluster. If not provided, will be treated as 0.
    initial_cluster_size: ?i32 = null,

    /// The type of job for this cluster. Currently, the only job type supported for
    /// clusters
    /// is `LOCAL_USE`.
    ///
    /// For more information, see
    /// "https://docs.aws.amazon.com/snowball/latest/snowcone-guide/snow-device-types.html" (Snow
    /// Family Devices and Capacity) in the *Snowcone User Guide* or
    /// "https://docs.aws.amazon.com/snowball/latest/developer-guide/snow-device-types.html" (Snow
    /// Family Devices and Capacity) in the *Snowcone User Guide*.
    job_type: JobType,

    /// The `KmsKeyARN` value that you want to associate with this cluster.
    /// `KmsKeyARN` values are created by using the
    /// [CreateKey](https://docs.aws.amazon.com/kms/latest/APIReference/API_CreateKey.html) API action in Key Management Service (KMS).
    kms_key_arn: ?[]const u8 = null,

    /// Lists long-term pricing id that will be used to associate with jobs
    /// automatically created for the new cluster.
    long_term_pricing_ids: ?[]const []const u8 = null,

    /// The Amazon Simple Notification Service (Amazon SNS) notification settings
    /// for this
    /// cluster.
    notification: ?Notification = null,

    /// Specifies the service or services on the Snow Family device that your
    /// transferred data
    /// will be exported from or imported into. Amazon Web Services Snow Family
    /// device clusters support Amazon S3 and NFS
    /// (Network File System).
    on_device_service_configuration: ?OnDeviceServiceConfiguration = null,

    /// Allows you to securely operate and manage Snow devices in a cluster remotely
    /// from outside
    /// of your internal network. When set to `INSTALLED_AUTOSTART`, remote
    /// management will
    /// automatically be available when the device arrives at your location.
    /// Otherwise, you need to
    /// use the Snowball Client to manage the device.
    remote_management: ?RemoteManagement = null,

    /// The resources associated with the cluster job. These resources include
    /// Amazon S3
    /// buckets and optional Lambda functions written in the Python language.
    resources: ?JobResource = null,

    /// The `RoleARN` that you want to associate with this cluster.
    /// `RoleArn` values are created by using the
    /// [CreateRole](https://docs.aws.amazon.com/IAM/latest/APIReference/API_CreateRole.html) API action in Identity and Access Management (IAM).
    role_arn: ?[]const u8 = null,

    /// The shipping speed for each node in this cluster. This speed doesn't dictate
    /// how soon
    /// you'll get each Snowball Edge device, rather it represents how quickly each
    /// device moves to
    /// its destination while in transit. Regional shipping speeds are as follows:
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
    /// * In the United States of America (US), you have access to one-day shipping
    ///   and
    /// two-day shipping.
    ///
    /// * In Australia, you have access to express shipping. Typically, devices
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
    shipping_option: ShippingOption,

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

    /// The type of Snow Family devices to use for this cluster.
    ///
    /// For cluster jobs, Amazon Web Services Snow Family currently supports only
    /// the
    /// `EDGE` device type.
    ///
    /// For more information, see
    /// "https://docs.aws.amazon.com/snowball/latest/snowcone-guide/snow-device-types.html" (Snow
    /// Family Devices and Capacity) in the *Snowcone User Guide* or
    /// "https://docs.aws.amazon.com/snowball/latest/developer-guide/snow-device-types.html" (Snow
    /// Family Devices and Capacity) in the *Snowcone User Guide*.
    snowball_type: SnowballType,

    /// The tax documents required in your Amazon Web Services Region.
    tax_documents: ?TaxDocuments = null,

    pub const json_field_names = .{
        .address_id = "AddressId",
        .description = "Description",
        .force_create_jobs = "ForceCreateJobs",
        .forwarding_address_id = "ForwardingAddressId",
        .initial_cluster_size = "InitialClusterSize",
        .job_type = "JobType",
        .kms_key_arn = "KmsKeyARN",
        .long_term_pricing_ids = "LongTermPricingIds",
        .notification = "Notification",
        .on_device_service_configuration = "OnDeviceServiceConfiguration",
        .remote_management = "RemoteManagement",
        .resources = "Resources",
        .role_arn = "RoleARN",
        .shipping_option = "ShippingOption",
        .snowball_capacity_preference = "SnowballCapacityPreference",
        .snowball_type = "SnowballType",
        .tax_documents = "TaxDocuments",
    };
};

pub const CreateClusterOutput = struct {
    /// The automatically generated ID for a cluster.
    cluster_id: ?[]const u8 = null,

    /// List of jobs created for this cluster. For syntax, see
    /// [ListJobsResult$JobListEntries](http://amazonaws.com/snowball/latest/api-reference/API_ListJobs.html#API_ListJobs_ResponseSyntax) in this guide.
    job_list_entries: ?[]const JobListEntry = null,

    pub const json_field_names = .{
        .cluster_id = "ClusterId",
        .job_list_entries = "JobListEntries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateClusterInput, options: CallOptions) !CreateClusterOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateClusterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("snowball", "Snowball", allocator);

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
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSIESnowballJobManagementService.CreateCluster");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateClusterOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateClusterOutput, body, allocator);
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
