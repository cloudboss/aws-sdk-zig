const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const LocationConfiguration = @import("location_configuration.zig").LocationConfiguration;
const DefaultApplication = @import("default_application.zig").DefaultApplication;
const LocationState = @import("location_state.zig").LocationState;
const StreamGroupStatus = @import("stream_group_status.zig").StreamGroupStatus;
const StreamGroupStatusReason = @import("stream_group_status_reason.zig").StreamGroupStatusReason;
const StreamClass = @import("stream_class.zig").StreamClass;

pub const UpdateStreamGroupInput = struct {
    /// The unique identifier of the Amazon GameLift Streams application that you
    /// want to set as the default application in a stream group. The application
    /// that you specify must be in `READY` status. The default application is
    /// pre-cached on always-on compute resources, reducing stream startup times.
    /// Other applications are automatically cached as needed.
    ///
    /// Note that this parameter only sets the default application in a stream
    /// group. To associate a new application to an existing stream group, you must
    /// use
    /// [AssociateApplications](https://docs.aws.amazon.com/gameliftstreams/latest/apireference/API_AssociateApplications.html).
    ///
    /// When you switch default applications in a stream group, it can take up to a
    /// few hours for the new default application to be pre-cached.
    ///
    /// This value is an [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// or ID that uniquely identifies the application resource. Example ARN:
    /// `arn:aws:gameliftstreams:us-west-2:111122223333:application/a-9ZY8X7Wv6`.
    /// Example ID: `a-9ZY8X7Wv6`.
    default_application_identifier: ?[]const u8 = null,

    /// A descriptive label for the stream group.
    description: ?[]const u8 = null,

    /// An [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// or ID that uniquely identifies the stream group resource. Example ARN:
    /// `arn:aws:gameliftstreams:us-west-2:111122223333:streamgroup/sg-1AB2C3De4`.
    /// Example ID: `sg-1AB2C3De4`.
    identifier: []const u8,

    /// A set of one or more locations and the streaming capacity for each location.
    location_configurations: ?[]const LocationConfiguration = null,

    pub const json_field_names = .{
        .default_application_identifier = "DefaultApplicationIdentifier",
        .description = "Description",
        .identifier = "Identifier",
        .location_configurations = "LocationConfigurations",
    };
};

pub const UpdateStreamGroupOutput = struct {
    /// The [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// that is assigned to the stream group resource and that uniquely identifies
    /// the group across all Amazon Web Services Regions. Format is
    /// `arn:aws:gameliftstreams:[AWS Region]:[AWS account]:streamgroup/[resource
    /// ID]`.
    arn: []const u8,

    /// A set of applications that this stream group is associated with. You can
    /// stream any of these applications with the stream group.
    ///
    /// This value is a set of [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html) that uniquely identify application resources. Example ARN: `arn:aws:gameliftstreams:us-west-2:111122223333:application/a-9ZY8X7Wv6`.
    associated_applications: ?[]const []const u8 = null,

    /// A timestamp that indicates when this resource was created. Timestamps are
    /// expressed using in ISO8601 format, such as: `2022-12-27T22:29:40+00:00`
    /// (UTC).
    created_at: ?i64 = null,

    /// The default Amazon GameLift Streams application that is associated with this
    /// stream group.
    default_application: ?DefaultApplication = null,

    /// A descriptive label for the stream group.
    description: ?[]const u8 = null,

    /// The time at which this stream group expires. Timestamps are expressed using
    /// in ISO8601 format, such as: `2022-12-27T22:29:40+00:00` (UTC). After this
    /// time, you will no longer be able to update this stream group or use it to
    /// start stream sessions. Only Get and Delete operations will work on an
    /// expired stream group.
    expires_at: ?i64 = null,

    /// A unique ID value that is assigned to the resource when it's created. Format
    /// example: `sg-1AB2C3De4`.
    id: ?[]const u8 = null,

    /// A timestamp that indicates when this resource was last updated. Timestamps
    /// are expressed using in ISO8601 format, such as: `2022-12-27T22:29:40+00:00`
    /// (UTC).
    last_updated_at: ?i64 = null,

    /// This value is set of locations, including their name, current status, and
    /// capacities.
    ///
    /// A location can be in one of the following states:
    ///
    /// * `ACTIVATING`: Amazon GameLift Streams is preparing the location. You
    ///   cannot stream from, scale the capacity of, or remove this location yet.
    /// * `ACTIVE`: The location is provisioned with initial capacity. You can now
    ///   stream from, scale the capacity of, or remove this location.
    /// * `ERROR`: Amazon GameLift Streams failed to set up this location. The
    ///   `StatusReason` field describes the error. You can remove this location and
    ///   try to add it again.
    /// * `REMOVING`: Amazon GameLift Streams is working to remove this location.
    ///   This will release all provisioned capacity for this location in this
    ///   stream group.
    location_states: ?[]const LocationState = null,

    /// The current status of the stream group resource. Possible statuses include
    /// the following:
    ///
    /// * `ACTIVATING`: The stream group is deploying and isn't ready to host
    ///   streams.
    /// * `ACTIVE`: The stream group is ready to host streams.
    /// * `ACTIVE_WITH_ERRORS`: One or more locations in the stream group are in an
    ///   error state. Verify the details of individual locations and remove any
    ///   locations which are in error.
    /// * `DELETING`: Amazon GameLift Streams is in the process of deleting the
    ///   stream group.
    /// * `ERROR`: An error occurred when the stream group deployed. See
    ///   `StatusReason` (returned by `CreateStreamGroup`, `GetStreamGroup`, and
    ///   `UpdateStreamGroup`) for more information.
    /// * `EXPIRED`: The stream group is expired and can no longer host streams.
    ///   This typically occurs when a stream group is 365 days old, as indicated by
    ///   the value of `ExpiresAt`. Create a new stream group to resume streaming
    ///   capabilities.
    /// * `UPDATING_LOCATIONS`: One or more locations in the stream group are in the
    ///   process of updating (either activating or deleting).
    status: ?StreamGroupStatus = null,

    /// A short description of the reason that the stream group is in `ERROR`
    /// status. The possible reasons can be one of the following:
    ///
    /// * `internalError`: The request can't process right now because of an issue
    ///   with the server. Try again later.
    /// * `noAvailableInstances`: Amazon GameLift Streams does not currently have
    ///   enough available capacity to fulfill your request. Wait a few minutes and
    ///   retry the request as capacity can shift frequently. You can also try to
    ///   make the request using a different stream class or in another region.
    status_reason: ?StreamGroupStatusReason = null,

    /// The target stream quality for the stream group.
    ///
    /// A stream class can be one of the following:
    ///
    /// * ** `gen6n_pro_win2022` (NVIDIA, pro)** Supports applications with
    ///   extremely high 3D scene complexity which require maximum resources. Runs
    ///   applications on Microsoft Windows Server 2022 Base and supports DirectX
    ///   12. Compatible with Unreal Engine versions up through 5.6, 32 and 64-bit
    ///   applications, and anti-cheat technology. Uses NVIDIA L4 Tensor Core GPU.
    ///
    /// * Reference resolution: 1080p
    /// * Reference frame rate: 60 fps
    /// * Workload specifications: 16 vCPUs, 64 GB RAM, 24 GB VRAM
    /// * Tenancy: Supports 1 concurrent stream session
    ///
    /// * ** `gen6n_pro` (NVIDIA, pro)** Supports applications with extremely high
    ///   3D scene complexity which require maximum resources. Uses dedicated NVIDIA
    ///   L4 Tensor Core GPU.
    ///
    /// * Reference resolution: 1080p
    /// * Reference frame rate: 60 fps
    /// * Workload specifications: 16 vCPUs, 64 GB RAM, 24 GB VRAM
    /// * Tenancy: Supports 1 concurrent stream session
    ///
    /// * ** `gen6n_ultra_win2022` (NVIDIA, ultra)** Supports applications with high
    ///   3D scene complexity. Runs applications on Microsoft Windows Server 2022
    ///   Base and supports DirectX 12. Compatible with Unreal Engine versions up
    ///   through 5.6, 32 and 64-bit applications, and anti-cheat technology. Uses
    ///   NVIDIA L4 Tensor Core GPU.
    ///
    /// * Reference resolution: 1080p
    /// * Reference frame rate: 60 fps
    /// * Workload specifications: 8 vCPUs, 32 GB RAM, 24 GB VRAM
    /// * Tenancy: Supports 1 concurrent stream session
    ///
    /// * ** `gen6n_ultra` (NVIDIA, ultra)** Supports applications with high 3D
    ///   scene complexity. Uses dedicated NVIDIA L4 Tensor Core GPU.
    ///
    /// * Reference resolution: 1080p
    /// * Reference frame rate: 60 fps
    /// * Workload specifications: 8 vCPUs, 32 GB RAM, 24 GB VRAM
    /// * Tenancy: Supports 1 concurrent stream session
    ///
    /// * ** `gen6n_high` (NVIDIA, high)** Supports applications with moderate to
    ///   high 3D scene complexity. Uses NVIDIA L4 Tensor Core GPU.
    ///
    /// * Reference resolution: 1080p
    /// * Reference frame rate: 60 fps
    /// * Workload specifications: 4 vCPUs, 16 GB RAM, 12 GB VRAM
    /// * Tenancy: Supports up to 2 concurrent stream sessions
    ///
    /// * ** `gen6n_medium` (NVIDIA, medium)** Supports applications with moderate
    ///   3D scene complexity. Uses NVIDIA L4 Tensor Core GPU.
    ///
    /// * Reference resolution: 1080p
    /// * Reference frame rate: 60 fps
    /// * Workload specifications: 2 vCPUs, 8 GB RAM, 6 GB VRAM
    /// * Tenancy: Supports up to 4 concurrent stream sessions
    ///
    /// * ** `gen6n_small` (NVIDIA, small)** Supports applications with lightweight
    ///   3D scene complexity and low CPU usage. Uses NVIDIA L4 Tensor Core GPU.
    ///
    /// * Reference resolution: 1080p
    /// * Reference frame rate: 60 fps
    /// * Workload specifications: 1 vCPUs, 4 GB RAM, 2 GB VRAM
    /// * Tenancy: Supports up to 12 concurrent stream sessions
    ///
    /// * ** `gen5n_win2022` (NVIDIA, ultra)** Supports applications with extremely
    ///   high 3D scene complexity. Runs applications on Microsoft Windows Server
    ///   2022 Base and supports DirectX 12. Compatible with Unreal Engine versions
    ///   up through 5.6, 32 and 64-bit applications, and anti-cheat technology.
    ///   Uses NVIDIA A10G Tensor Core GPU.
    ///
    /// * Reference resolution: 1080p
    /// * Reference frame rate: 60 fps
    /// * Workload specifications: 8 vCPUs, 32 GB RAM, 24 GB VRAM
    /// * Tenancy: Supports 1 concurrent stream session
    ///
    /// * ** `gen5n_high` (NVIDIA, high)** Supports applications with moderate to
    ///   high 3D scene complexity. Uses NVIDIA A10G Tensor Core GPU.
    ///
    /// * Reference resolution: 1080p
    /// * Reference frame rate: 60 fps
    /// * Workload specifications: 4 vCPUs, 16 GB RAM, 12 GB VRAM
    /// * Tenancy: Supports up to 2 concurrent stream sessions
    ///
    /// * ** `gen5n_ultra` (NVIDIA, ultra)** Supports applications with extremely
    ///   high 3D scene complexity. Uses dedicated NVIDIA A10G Tensor Core GPU.
    ///
    /// * Reference resolution: 1080p
    /// * Reference frame rate: 60 fps
    /// * Workload specifications: 8 vCPUs, 32 GB RAM, 24 GB VRAM
    /// * Tenancy: Supports 1 concurrent stream session
    ///
    /// * ** `gen4n_win2022` (NVIDIA, ultra)** Supports applications with extremely
    ///   high 3D scene complexity. Runs applications on Microsoft Windows Server
    ///   2022 Base and supports DirectX 12. Compatible with Unreal Engine versions
    ///   up through 5.6, 32 and 64-bit applications, and anti-cheat technology.
    ///   Uses NVIDIA T4 Tensor Core GPU.
    ///
    /// * Reference resolution: 1080p
    /// * Reference frame rate: 60 fps
    /// * Workload specifications: 8 vCPUs, 32 GB RAM, 16 GB VRAM
    /// * Tenancy: Supports 1 concurrent stream session
    ///
    /// * ** `gen4n_high` (NVIDIA, high)** Supports applications with moderate to
    ///   high 3D scene complexity. Uses NVIDIA T4 Tensor Core GPU.
    ///
    /// * Reference resolution: 1080p
    /// * Reference frame rate: 60 fps
    /// * Workload specifications: 4 vCPUs, 16 GB RAM, 8 GB VRAM
    /// * Tenancy: Supports up to 2 concurrent stream sessions
    ///
    /// * ** `gen4n_ultra` (NVIDIA, ultra)** Supports applications with high 3D
    ///   scene complexity. Uses dedicated NVIDIA T4 Tensor Core GPU.
    ///
    /// * Reference resolution: 1080p
    /// * Reference frame rate: 60 fps
    /// * Workload specifications: 8 vCPUs, 32 GB RAM, 16 GB VRAM
    /// * Tenancy: Supports 1 concurrent stream session
    stream_class: ?StreamClass = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .associated_applications = "AssociatedApplications",
        .created_at = "CreatedAt",
        .default_application = "DefaultApplication",
        .description = "Description",
        .expires_at = "ExpiresAt",
        .id = "Id",
        .last_updated_at = "LastUpdatedAt",
        .location_states = "LocationStates",
        .status = "Status",
        .status_reason = "StatusReason",
        .stream_class = "StreamClass",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateStreamGroupInput, options: CallOptions) !UpdateStreamGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "gameliftstreams");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateStreamGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("gameliftstreams", "GameLiftStreams", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/streamgroups/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.default_application_identifier) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DefaultApplicationIdentifier\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.location_configurations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LocationConfigurations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PATCH;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateStreamGroupOutput {
    var result: UpdateStreamGroupOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateStreamGroupOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
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
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
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
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
