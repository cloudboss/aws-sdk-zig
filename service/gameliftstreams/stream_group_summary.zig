const DefaultApplication = @import("default_application.zig").DefaultApplication;
const StreamGroupStatus = @import("stream_group_status.zig").StreamGroupStatus;
const StreamClass = @import("stream_class.zig").StreamClass;

/// Describes a Amazon GameLift Streams stream group resource for hosting
/// content streams. To retrieve additional stream group details, call
/// [GetStreamGroup](https://docs.aws.amazon.com/gameliftstreams/latest/apireference/API_GetStreamGroup.html).
pub const StreamGroupSummary = struct {
    /// An [Amazon Resource Name
    /// (ARN)](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference-arns.html)
    /// that uniquely identifies the stream group resource. Example ARN:
    /// `arn:aws:gameliftstreams:us-west-2:111122223333:streamgroup/sg-1AB2C3De4`.
    arn: []const u8,

    /// A timestamp that indicates when this resource was created. Timestamps are
    /// expressed using in ISO8601 format, such as: `2022-12-27T22:29:40+00:00`
    /// (UTC).
    created_at: ?i64 = null,

    /// Object that identifies the Amazon GameLift Streams application to stream
    /// with this stream group.
    default_application: ?DefaultApplication = null,

    /// A descriptive label for the stream group.
    description: ?[]const u8 = null,

    /// The time at which this stream group expires. Timestamps are expressed using
    /// in ISO8601 format, such as: `2022-12-27T22:29:40+00:00` (UTC). After this
    /// time, you will no longer be able to update this stream group or use it to
    /// start stream sessions. Only Get and Delete operations will work on an
    /// expired stream group.
    expires_at: ?i64 = null,

    /// An ID that uniquely identifies the stream group resource. Example ID:
    /// `sg-1AB2C3De4`.
    id: ?[]const u8 = null,

    /// A timestamp that indicates when this resource was last updated. Timestamps
    /// are expressed using in ISO8601 format, such as: `2022-12-27T22:29:40+00:00`
    /// (UTC).
    last_updated_at: ?i64 = null,

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
        .created_at = "CreatedAt",
        .default_application = "DefaultApplication",
        .description = "Description",
        .expires_at = "ExpiresAt",
        .id = "Id",
        .last_updated_at = "LastUpdatedAt",
        .status = "Status",
        .stream_class = "StreamClass",
    };
};
