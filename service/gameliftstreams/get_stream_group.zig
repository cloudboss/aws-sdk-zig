const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DefaultApplication = @import("default_application.zig").DefaultApplication;
const LocationState = @import("location_state.zig").LocationState;
const StreamGroupStatus = @import("stream_group_status.zig").StreamGroupStatus;
const StreamGroupStatusReason = @import("stream_group_status_reason.zig").StreamGroupStatusReason;
const StreamClass = @import("stream_class.zig").StreamClass;

pub const GetStreamGroupInput = struct {
    /// An [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// or ID that uniquely identifies the stream group resource. Example ARN:
    /// `arn:aws:gameliftstreams:us-west-2:111122223333:streamgroup/sg-1AB2C3De4`.
    /// Example ID: `sg-1AB2C3De4`.
    identifier: []const u8,

    pub const json_field_names = .{
        .identifier = "Identifier",
    };
};

pub const GetStreamGroupOutput = struct {
    /// The [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// that is assigned to the stream group resource and that uniquely identifies
    /// the group across all Amazon Web Services Regions. Format is
    /// `arn:aws:gameliftstreams:[AWS Region]:[AWS account]:streamgroup/[resource
    /// ID]`.
    arn: []const u8,

    /// A set of applications that this stream group is associated to. You can
    /// stream any of these applications by using this stream group.
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

    /// This value is the set of locations, including their name, current status,
    /// and capacities.
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
    ///   applications, and anti-cheat technology. Powered by NVIDIA L4 Tensor Core
    ///   GPUs.
    ///
    /// * Reference resolution: 1080p
    /// * Reference frame rate: 60 fps
    /// * Workload specifications: 16 vCPUs, 64 GB RAM, 24 GB VRAM
    /// * Tenancy: Supports 1 concurrent stream session
    ///
    /// * ** `gen6n_pro` (NVIDIA, pro)** Supports applications with extremely high
    ///   3D scene complexity which require maximum resources. Powered by NVIDIA L4
    ///   Tensor Core GPUs.
    ///
    /// * Reference resolution: 1080p
    /// * Reference frame rate: 60 fps
    /// * Workload specifications: 16 vCPUs, 64 GB RAM, 24 GB VRAM
    /// * Tenancy: Supports 1 concurrent stream session
    ///
    /// * ** `gen6n_ultra_win2022` (NVIDIA, ultra)** Supports applications with high
    ///   3D scene complexity. Runs applications on Microsoft Windows Server 2022
    ///   Base and supports DirectX 12. Compatible with Unreal Engine versions up
    ///   through 5.6, 32 and 64-bit applications, and anti-cheat technology.
    ///   Powered by NVIDIA L4 Tensor Core GPUs.
    ///
    /// * Reference resolution: 1080p
    /// * Reference frame rate: 60 fps
    /// * Workload specifications: 8 vCPUs, 32 GB RAM, 24 GB VRAM
    /// * Tenancy: Supports 1 concurrent stream session
    ///
    /// * ** `gen6n_ultra` (NVIDIA, ultra)** Supports applications with high 3D
    ///   scene complexity. Powered by NVIDIA L4 Tensor Core GPUs.
    ///
    /// * Reference resolution: 1080p
    /// * Reference frame rate: 60 fps
    /// * Workload specifications: 8 vCPUs, 32 GB RAM, 24 GB VRAM
    /// * Tenancy: Supports 1 concurrent stream session
    ///
    /// * ** `gen6n_high` (NVIDIA, high)** Supports applications with moderate to
    ///   high 3D scene complexity. Powered by NVIDIA L4 Tensor Core GPUs.
    ///
    /// * Reference resolution: 1080p
    /// * Reference frame rate: 60 fps
    /// * Workload specifications: 4 vCPUs, 16 GB RAM, 12 GB VRAM
    /// * Tenancy: Supports up to 2 concurrent stream sessions
    ///
    /// * ** `gen6n_medium` (NVIDIA, medium)** Supports applications with moderate
    ///   3D scene complexity. Powered by NVIDIA L4 Tensor Core GPUs.
    ///
    /// * Reference resolution: 1080p
    /// * Reference frame rate: 60 fps
    /// * Workload specifications: 2 vCPUs, 8 GB RAM, 6 GB VRAM
    /// * Tenancy: Supports up to 4 concurrent stream sessions
    ///
    /// * ** `gen6n_small` (NVIDIA, small)** Supports applications with lightweight
    ///   3D scene complexity and low CPU usage. Powered by NVIDIA L4 Tensor Core
    ///   GPUs.
    ///
    /// * Reference resolution: 1080p
    /// * Reference frame rate: 60 fps
    /// * Workload specifications: 1 vCPUs, 4 GB RAM, 2 GB VRAM
    /// * Tenancy: Supports up to 12 concurrent stream sessions
    ///
    /// * ** `gen6n_medium_win2022` (NVIDIA, medium)** Supports applications with
    ///   low 3D scene complexity. Powered by NVIDIA L4 Tensor Core GPUs.
    ///
    /// * Reference resolution: 1080p
    /// * Reference frame rate: 60 fps
    /// * Workload specifications: 8 vCPUs, 32 GB RAM, 6 GB VRAM
    /// * Tenancy: Supports 1 concurrent stream session
    ///
    /// * ** `gen6n_small_win2022` (NVIDIA, small)** Supports applications with low
    ///   3D scene complexity. Powered by NVIDIA L4 Tensor Core GPUs.
    ///
    /// * Reference resolution: 1080p
    /// * Reference frame rate: 60 fps
    /// * Workload specifications: 2 vCPUs, 8 GB RAM, 3 GB VRAM
    /// * Tenancy: Supports 1 concurrent stream session
    ///
    /// * ** `gen6e_pro_win2022` (NVIDIA, pro)** Supports applications with
    ///   extremely high 3D scene complexity which require maximum resources. Runs
    ///   applications on Microsoft Windows Server 2022 Base and supports DirectX
    ///   12. Compatible with Unreal Engine versions up through 5.6, 32 and 64-bit
    ///   applications, and anti-cheat technology. Powered by NVIDIA L40S Tensor
    ///   Core GPUs.
    ///
    /// * Reference resolution: 1080p
    /// * Reference frame rate: 60 fps
    /// * Workload specifications: 16 vCPUs, 128 GB RAM, 48 GB VRAM
    /// * Tenancy: Supports 1 concurrent stream session
    ///
    /// * ** `gen6e_pro` (NVIDIA, pro)** Supports applications with extremely high
    ///   3D scene complexity which require maximum resources. Powered by NVIDIA
    ///   L40S Tensor Core GPUs.
    ///
    /// * Reference resolution: 1080p
    /// * Reference frame rate: 60 fps
    /// * Workload specifications: 16 vCPUs, 128 GB RAM, 48 GB VRAM
    /// * Tenancy: Supports 1 concurrent stream session
    ///
    /// * ** `gen5n_win2022` (NVIDIA, ultra)** Supports applications with extremely
    ///   high 3D scene complexity. Runs applications on Microsoft Windows Server
    ///   2022 Base and supports DirectX 12. Compatible with Unreal Engine versions
    ///   up through 5.6, 32 and 64-bit applications, and anti-cheat technology.
    ///   Powered by NVIDIA A10G Tensor Core GPUs.
    ///
    /// * Reference resolution: 1080p
    /// * Reference frame rate: 60 fps
    /// * Workload specifications: 8 vCPUs, 32 GB RAM, 24 GB VRAM
    /// * Tenancy: Supports 1 concurrent stream session
    ///
    /// * ** `gen5n_high` (NVIDIA, high)** Supports applications with moderate to
    ///   high 3D scene complexity. Powered by NVIDIA A10G Tensor Core GPUs.
    ///
    /// * Reference resolution: 1080p
    /// * Reference frame rate: 60 fps
    /// * Workload specifications: 4 vCPUs, 16 GB RAM, 12 GB VRAM
    /// * Tenancy: Supports up to 2 concurrent stream sessions
    ///
    /// * ** `gen5n_ultra` (NVIDIA, ultra)** Supports applications with extremely
    ///   high 3D scene complexity. Powered by NVIDIA A10G Tensor Core GPUs.
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
    ///   Powered by NVIDIA T4 Tensor Core GPUs.
    ///
    /// * Reference resolution: 1080p
    /// * Reference frame rate: 60 fps
    /// * Workload specifications: 8 vCPUs, 32 GB RAM, 16 GB VRAM
    /// * Tenancy: Supports 1 concurrent stream session
    ///
    /// * ** `gen4n_high` (NVIDIA, high)** Supports applications with moderate to
    ///   high 3D scene complexity. Powered by NVIDIA T4 Tensor Core GPUs.
    ///
    /// * Reference resolution: 1080p
    /// * Reference frame rate: 60 fps
    /// * Workload specifications: 4 vCPUs, 16 GB RAM, 8 GB VRAM
    /// * Tenancy: Supports up to 2 concurrent stream sessions
    ///
    /// * ** `gen4n_ultra` (NVIDIA, ultra)** Supports applications with high 3D
    ///   scene complexity. Powered by NVIDIA T4 Tensor Core GPUs.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetStreamGroupInput, options: CallOptions) !GetStreamGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "gameliftstreams", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetStreamGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("gameliftstreams", "GameLiftStreams", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/streamgroups/");
    try path_buf.appendSlice(allocator, input.identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetStreamGroupOutput {
    const result: GetStreamGroupOutput = try aws.json.parseJsonObject(
        GetStreamGroupOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
