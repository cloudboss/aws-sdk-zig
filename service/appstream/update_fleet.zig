const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const FleetAttribute = @import("fleet_attribute.zig").FleetAttribute;
const ComputeCapacity = @import("compute_capacity.zig").ComputeCapacity;
const DomainJoinInfo = @import("domain_join_info.zig").DomainJoinInfo;
const PlatformType = @import("platform_type.zig").PlatformType;
const VolumeConfig = @import("volume_config.zig").VolumeConfig;
const S3Location = @import("s3_location.zig").S3Location;
const StreamView = @import("stream_view.zig").StreamView;
const VpcConfig = @import("vpc_config.zig").VpcConfig;
const Fleet = @import("fleet.zig").Fleet;

pub const UpdateFleetInput = struct {
    /// The fleet attributes to delete.
    attributes_to_delete: ?[]const FleetAttribute = null,

    /// The desired capacity for the fleet. This is not allowed for Elastic fleets.
    compute_capacity: ?ComputeCapacity = null,

    /// Deletes the VPC association for the specified fleet.
    delete_vpc_config: ?bool = null,

    /// The description to display.
    description: ?[]const u8 = null,

    /// Set to true to disable Instance Metadata Service Version 1 (IMDSv1) and
    /// enforce IMDSv2. Set to false to enable both IMDSv1 and IMDSv2.
    ///
    /// Before disabling IMDSv1, ensure your WorkSpaces Applications images are
    /// running the agent version or managed image update released on or after
    /// January 16, 2024 to support IMDSv2 enforcement.
    disable_imdsv1: ?bool = null,

    /// The amount of time that a streaming session remains active after users
    /// disconnect. If users try to reconnect to the streaming session after a
    /// disconnection or network interruption within this time interval, they are
    /// connected to their previous session. Otherwise, they are connected to a new
    /// session with a new streaming instance.
    ///
    /// Specify a value between 60 and 36000.
    disconnect_timeout_in_seconds: ?i32 = null,

    /// The fleet name to display.
    display_name: ?[]const u8 = null,

    /// The name of the directory and organizational unit (OU) to use to join the
    /// fleet to a Microsoft Active Directory domain.
    domain_join_info: ?DomainJoinInfo = null,

    /// Enables or disables default internet access for the fleet.
    enable_default_internet_access: ?bool = null,

    /// The Amazon Resource Name (ARN) of the IAM role to apply to the fleet. To
    /// assume a role, a fleet instance calls the AWS Security Token Service (STS)
    /// `AssumeRole` API operation and passes the ARN of the role to use. The
    /// operation creates a new session with temporary credentials. WorkSpaces
    /// Applications retrieves the temporary credentials and creates the
    /// **appstream_machine_role** credential profile on the instance.
    ///
    /// For more information, see [Using an IAM Role to Grant Permissions to
    /// Applications and Scripts Running on WorkSpaces Applications Streaming
    /// Instances](https://docs.aws.amazon.com/appstream2/latest/developerguide/using-iam-roles-to-grant-permissions-to-applications-scripts-streaming-instances.html) in the *Amazon WorkSpaces Applications Administration Guide*.
    iam_role_arn: ?[]const u8 = null,

    /// The amount of time that users can be idle (inactive) before they are
    /// disconnected
    /// from their streaming session and the `DisconnectTimeoutInSeconds` time
    /// interval begins. Users are notified before they are disconnected due to
    /// inactivity. If
    /// users try to reconnect to the streaming session before the time interval
    /// specified in
    /// `DisconnectTimeoutInSeconds` elapses, they are connected to their
    /// previous session. Users are considered idle when they stop providing
    /// keyboard or mouse
    /// input during their streaming session. File uploads and downloads, audio in,
    /// audio out,
    /// and pixels changing do not qualify as user activity. If users continue to be
    /// idle after
    /// the time interval in `IdleDisconnectTimeoutInSeconds` elapses, they are
    /// disconnected.
    ///
    /// To prevent users from being disconnected due to inactivity, specify a value
    /// of 0. Otherwise, specify a value between 60 and 36000. The default value is
    /// 0.
    ///
    /// If you enable this feature, we recommend that you specify a value that
    /// corresponds exactly to a whole number of minutes (for example, 60, 120, and
    /// 180). If you don't do this, the value is rounded to the nearest minute. For
    /// example, if you specify a value of 70, users are disconnected after 1 minute
    /// of inactivity. If you specify a value that is at the midpoint between two
    /// different minutes, the value is rounded up. For example, if you specify a
    /// value of 90, users are disconnected after 2 minutes of inactivity.
    idle_disconnect_timeout_in_seconds: ?i32 = null,

    /// The ARN of the public, private, or shared image to use.
    image_arn: ?[]const u8 = null,

    /// The name of the image used to create the fleet.
    image_name: ?[]const u8 = null,

    /// The instance type to use when launching fleet instances. The following
    /// instance types are available:
    ///
    /// * stream.standard.small
    ///
    /// * stream.standard.medium
    ///
    /// * stream.standard.large
    ///
    /// * stream.standard.xlarge
    ///
    /// * stream.standard.2xlarge
    ///
    /// * stream.compute.large
    ///
    /// * stream.compute.xlarge
    ///
    /// * stream.compute.2xlarge
    ///
    /// * stream.compute.4xlarge
    ///
    /// * stream.compute.8xlarge
    ///
    /// * stream.memory.large
    ///
    /// * stream.memory.xlarge
    ///
    /// * stream.memory.2xlarge
    ///
    /// * stream.memory.4xlarge
    ///
    /// * stream.memory.8xlarge
    ///
    /// * stream.memory.z1d.large
    ///
    /// * stream.memory.z1d.xlarge
    ///
    /// * stream.memory.z1d.2xlarge
    ///
    /// * stream.memory.z1d.3xlarge
    ///
    /// * stream.memory.z1d.6xlarge
    ///
    /// * stream.memory.z1d.12xlarge
    ///
    /// * stream.graphics.g4dn.xlarge
    ///
    /// * stream.graphics.g4dn.2xlarge
    ///
    /// * stream.graphics.g4dn.4xlarge
    ///
    /// * stream.graphics.g4dn.8xlarge
    ///
    /// * stream.graphics.g4dn.12xlarge
    ///
    /// * stream.graphics.g4dn.16xlarge
    ///
    /// * stream.graphics.g5.xlarge
    ///
    /// * stream.graphics.g5.2xlarge
    ///
    /// * stream.graphics.g5.4xlarge
    ///
    /// * stream.graphics.g5.8xlarge
    ///
    /// * stream.graphics.g5.16xlarge
    ///
    /// * stream.graphics.g5.12xlarge
    ///
    /// * stream.graphics.g5.24xlarge
    ///
    /// * stream.graphics.g6.xlarge
    ///
    /// * stream.graphics.g6.2xlarge
    ///
    /// * stream.graphics.g6.4xlarge
    ///
    /// * stream.graphics.g6.8xlarge
    ///
    /// * stream.graphics.g6.16xlarge
    ///
    /// * stream.graphics.g6.12xlarge
    ///
    /// * stream.graphics.g6.24xlarge
    ///
    /// * stream.graphics.gr6.4xlarge
    ///
    /// * stream.graphics.gr6.8xlarge
    ///
    /// * stream.graphics.g6f.large
    ///
    /// * stream.graphics.g6f.xlarge
    ///
    /// * stream.graphics.g6f.2xlarge
    ///
    /// * stream.graphics.g6f.4xlarge
    ///
    /// * stream.graphics.gr6f.4xlarge
    ///
    /// The following instance types are available for Elastic fleets:
    ///
    /// * stream.standard.small
    ///
    /// * stream.standard.medium
    ///
    /// * stream.standard.large
    ///
    /// * stream.standard.xlarge
    ///
    /// * stream.standard.2xlarge
    instance_type: ?[]const u8 = null,

    /// The maximum number of concurrent sessions for a fleet.
    max_concurrent_sessions: ?i32 = null,

    /// The maximum number of user sessions on an instance. This only applies to
    /// multi-session fleets.
    max_sessions_per_instance: ?i32 = null,

    /// The maximum amount of time that a streaming session can remain active, in
    /// seconds. If users are still connected to a streaming instance five minutes
    /// before this limit is reached, they are prompted to save any open documents
    /// before being disconnected. After this time elapses, the instance is
    /// terminated and replaced by a new instance.
    ///
    /// Specify a value between 600 and 432000.
    max_user_duration_in_seconds: ?i32 = null,

    /// A unique name for the fleet.
    name: ?[]const u8 = null,

    /// The platform of the fleet. WINDOWS_SERVER_2019, AMAZON_LINUX2 and
    /// UBUNTU_PRO_2404 are supported for Elastic fleets.
    platform: ?PlatformType = null,

    /// The updated configuration for the root volume of fleet instances. Note that
    /// volume size cannot be decreased below the image volume size.
    root_volume_config: ?VolumeConfig = null,

    /// The S3 location of the session scripts configuration zip file. This only
    /// applies to Elastic fleets.
    session_script_s3_location: ?S3Location = null,

    /// The WorkSpaces Applications view that is displayed to your users when they
    /// stream from the fleet. When `APP` is specified, only the windows of
    /// applications opened by users display. When `DESKTOP` is specified, the
    /// standard desktop that is provided by the operating system displays.
    ///
    /// The default value is `APP`.
    stream_view: ?StreamView = null,

    /// The USB device filter strings that specify which USB devices a user can
    /// redirect to the fleet streaming session, when using the Windows native
    /// client. This is allowed but not required for Elastic fleets.
    usb_device_filter_strings: ?[]const []const u8 = null,

    /// The VPC configuration for the fleet. This is required for Elastic fleets,
    /// but not required for other fleet types. Elastic fleets require that you
    /// specify at least two subnets in different availability zones.
    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .attributes_to_delete = "AttributesToDelete",
        .compute_capacity = "ComputeCapacity",
        .delete_vpc_config = "DeleteVpcConfig",
        .description = "Description",
        .disable_imdsv1 = "DisableIMDSV1",
        .disconnect_timeout_in_seconds = "DisconnectTimeoutInSeconds",
        .display_name = "DisplayName",
        .domain_join_info = "DomainJoinInfo",
        .enable_default_internet_access = "EnableDefaultInternetAccess",
        .iam_role_arn = "IamRoleArn",
        .idle_disconnect_timeout_in_seconds = "IdleDisconnectTimeoutInSeconds",
        .image_arn = "ImageArn",
        .image_name = "ImageName",
        .instance_type = "InstanceType",
        .max_concurrent_sessions = "MaxConcurrentSessions",
        .max_sessions_per_instance = "MaxSessionsPerInstance",
        .max_user_duration_in_seconds = "MaxUserDurationInSeconds",
        .name = "Name",
        .platform = "Platform",
        .root_volume_config = "RootVolumeConfig",
        .session_script_s3_location = "SessionScriptS3Location",
        .stream_view = "StreamView",
        .usb_device_filter_strings = "UsbDeviceFilterStrings",
        .vpc_config = "VpcConfig",
    };
};

pub const UpdateFleetOutput = struct {
    /// Information about the fleet.
    fleet: ?Fleet = null,

    pub const json_field_names = .{
        .fleet = "Fleet",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateFleetInput, options: CallOptions) !UpdateFleetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "appstream");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateFleetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appstream2", "AppStream", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "PhotonAdminProxyService.UpdateFleet");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateFleetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateFleetOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DryRunOperationException")) {
        return .{ .arena = arena, .kind = .{ .dry_run_operation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EntitlementAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .entitlement_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EntitlementNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .entitlement_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IncompatibleImageException")) {
        return .{ .arena = arena, .kind = .{ .incompatible_image_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAccountStatusException")) {
        return .{ .arena = arena, .kind = .{ .invalid_account_status_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterCombinationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_combination_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRoleException")) {
        return .{ .arena = arena, .kind = .{ .invalid_role_exception = .{
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
    if (std.mem.eql(u8, error_code, "OperationNotPermittedException")) {
        return .{ .arena = arena, .kind = .{ .operation_not_permitted_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RequestLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .request_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotAvailableException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_available_exception = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
