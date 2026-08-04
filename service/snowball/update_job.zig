const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
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

pub const UpdateJobOutput = struct {
};

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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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
        const parsed_error: ?errors.ClusterLimitExceededException = aws.json.parseJsonObject(errors.ClusterLimitExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .cluster_limit_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        const parsed_error: ?errors.ConflictException = aws.json.parseJsonObject(errors.ConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "Ec2RequestFailedException")) {
        const parsed_error: ?errors.Ec2RequestFailedException = aws.json.parseJsonObject(errors.Ec2RequestFailedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .ec_2_request_failed_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidAddressException")) {
        const parsed_error: ?errors.InvalidAddressException = aws.json.parseJsonObject(errors.InvalidAddressException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_address_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidInputCombinationException")) {
        const parsed_error: ?errors.InvalidInputCombinationException = aws.json.parseJsonObject(errors.InvalidInputCombinationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_input_combination_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidJobStateException")) {
        const parsed_error: ?errors.InvalidJobStateException = aws.json.parseJsonObject(errors.InvalidJobStateException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_job_state_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidNextTokenException")) {
        const parsed_error: ?errors.InvalidNextTokenException = aws.json.parseJsonObject(errors.InvalidNextTokenException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_next_token_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidResourceException")) {
        const parsed_error: ?errors.InvalidResourceException = aws.json.parseJsonObject(errors.InvalidResourceException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_resource_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "KMSRequestFailedException")) {
        const parsed_error: ?errors.KMSRequestFailedException = aws.json.parseJsonObject(errors.KMSRequestFailedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .kms_request_failed_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ReturnShippingLabelAlreadyExistsException")) {
        const parsed_error: ?errors.ReturnShippingLabelAlreadyExistsException = aws.json.parseJsonObject(errors.ReturnShippingLabelAlreadyExistsException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .return_shipping_label_already_exists_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "UnsupportedAddressException")) {
        const parsed_error: ?errors.UnsupportedAddressException = aws.json.parseJsonObject(errors.UnsupportedAddressException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .unsupported_address_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
