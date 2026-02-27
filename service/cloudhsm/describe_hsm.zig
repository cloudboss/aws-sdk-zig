const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const HsmStatus = @import("hsm_status.zig").HsmStatus;
const SubscriptionType = @import("subscription_type.zig").SubscriptionType;

pub const DescribeHsmInput = struct {
    /// The ARN of the HSM. Either the `HsmArn` or the `SerialNumber`
    /// parameter must be specified.
    hsm_arn: ?[]const u8 = null,

    /// The serial number of the HSM. Either the `HsmArn` or the
    /// `HsmSerialNumber` parameter must be specified.
    hsm_serial_number: ?[]const u8 = null,

    pub const json_field_names = .{
        .hsm_arn = "HsmArn",
        .hsm_serial_number = "HsmSerialNumber",
    };
};

pub const DescribeHsmOutput = struct {
    /// The Availability Zone that the HSM is in.
    availability_zone: ?[]const u8 = null,

    /// The identifier of the elastic network interface (ENI) attached to the HSM.
    eni_id: ?[]const u8 = null,

    /// The IP address assigned to the HSM's ENI.
    eni_ip: ?[]const u8 = null,

    /// The ARN of the HSM.
    hsm_arn: ?[]const u8 = null,

    /// The HSM model type.
    hsm_type: ?[]const u8 = null,

    /// The ARN of the IAM role assigned to the HSM.
    iam_role_arn: ?[]const u8 = null,

    /// The list of partitions on the HSM.
    partitions: ?[]const []const u8 = null,

    /// The serial number of the HSM.
    serial_number: ?[]const u8 = null,

    /// The date and time that the server certificate was last updated.
    server_cert_last_updated: ?[]const u8 = null,

    /// The URI of the certificate server.
    server_cert_uri: ?[]const u8 = null,

    /// The HSM software version.
    software_version: ?[]const u8 = null,

    /// The date and time that the SSH key was last updated.
    ssh_key_last_updated: ?[]const u8 = null,

    /// The public SSH key.
    ssh_public_key: ?[]const u8 = null,

    /// The status of the HSM.
    status: ?HsmStatus = null,

    /// Contains additional information about the status of the HSM.
    status_details: ?[]const u8 = null,

    /// The identifier of the subnet that the HSM is in.
    subnet_id: ?[]const u8 = null,

    /// The subscription end date.
    subscription_end_date: ?[]const u8 = null,

    /// The subscription start date.
    subscription_start_date: ?[]const u8 = null,

    subscription_type: ?SubscriptionType = null,

    /// The name of the HSM vendor.
    vendor_name: ?[]const u8 = null,

    /// The identifier of the VPC that the HSM is in.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .eni_id = "EniId",
        .eni_ip = "EniIp",
        .hsm_arn = "HsmArn",
        .hsm_type = "HsmType",
        .iam_role_arn = "IamRoleArn",
        .partitions = "Partitions",
        .serial_number = "SerialNumber",
        .server_cert_last_updated = "ServerCertLastUpdated",
        .server_cert_uri = "ServerCertUri",
        .software_version = "SoftwareVersion",
        .ssh_key_last_updated = "SshKeyLastUpdated",
        .ssh_public_key = "SshPublicKey",
        .status = "Status",
        .status_details = "StatusDetails",
        .subnet_id = "SubnetId",
        .subscription_end_date = "SubscriptionEndDate",
        .subscription_start_date = "SubscriptionStartDate",
        .subscription_type = "SubscriptionType",
        .vendor_name = "VendorName",
        .vpc_id = "VpcId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeHsmInput, options: Options) !DescribeHsmOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cloudhsm");

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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeHsmInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudhsm", "CloudHSM", alloc);

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
    try request.headers.put(alloc, "X-Amz-Target", "CloudHsmFrontendService.DescribeHsm");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeHsmOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeHsmOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "CloudHsmInternalException")) {
        return .{ .arena = arena, .kind = .{ .cloud_hsm_internal_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "CloudHsmServiceException")) {
        return .{ .arena = arena, .kind = .{ .cloud_hsm_service_exception = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
