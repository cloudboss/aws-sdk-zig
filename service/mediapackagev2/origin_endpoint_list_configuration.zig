const ContainerType = @import("container_type.zig").ContainerType;
const ListDashManifestConfiguration = @import("list_dash_manifest_configuration.zig").ListDashManifestConfiguration;
const ForceEndpointErrorConfiguration = @import("force_endpoint_error_configuration.zig").ForceEndpointErrorConfiguration;
const ListHlsManifestConfiguration = @import("list_hls_manifest_configuration.zig").ListHlsManifestConfiguration;
const ListLowLatencyHlsManifestConfiguration = @import("list_low_latency_hls_manifest_configuration.zig").ListLowLatencyHlsManifestConfiguration;
const ListMssManifestConfiguration = @import("list_mss_manifest_configuration.zig").ListMssManifestConfiguration;

/// The configuration of the origin endpoint.
pub const OriginEndpointListConfiguration = struct {
    /// The Amazon Resource Name (ARN) associated with the resource.
    arn: []const u8,

    /// The name that describes the channel group. The name is the primary
    /// identifier for the channel group, and must be unique for your account in the
    /// AWS Region.
    channel_group_name: []const u8,

    /// The name that describes the channel. The name is the primary identifier for
    /// the channel, and must be unique for your account in the AWS Region and
    /// channel group.
    channel_name: []const u8,

    /// The type of container attached to this origin endpoint. A container type is
    /// a file format that encapsulates one or more media streams, such as audio and
    /// video, into a single file.
    container_type: ContainerType,

    /// The date and time the origin endpoint was created.
    created_at: ?i64,

    /// A DASH manifest configuration.
    dash_manifests: ?[]const ListDashManifestConfiguration,

    /// Any descriptive information that you want to add to the origin endpoint for
    /// future identification purposes.
    description: ?[]const u8,

    /// The failover settings for the endpoint.
    force_endpoint_error_configuration: ?ForceEndpointErrorConfiguration,

    /// An HTTP live streaming (HLS) manifest configuration.
    hls_manifests: ?[]const ListHlsManifestConfiguration,

    /// A low-latency HLS manifest configuration.
    low_latency_hls_manifests: ?[]const ListLowLatencyHlsManifestConfiguration,

    /// The date and time the origin endpoint was modified.
    modified_at: ?i64,

    /// A list of Microsoft Smooth Streaming (MSS) manifest configurations
    /// associated with the origin endpoint. Each configuration represents a
    /// different MSS streaming option available from this endpoint.
    mss_manifests: ?[]const ListMssManifestConfiguration,

    /// The name that describes the origin endpoint. The name is the primary
    /// identifier for the origin endpoint, and and must be unique for your account
    /// in the AWS Region and channel.
    origin_endpoint_name: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .channel_group_name = "ChannelGroupName",
        .channel_name = "ChannelName",
        .container_type = "ContainerType",
        .created_at = "CreatedAt",
        .dash_manifests = "DashManifests",
        .description = "Description",
        .force_endpoint_error_configuration = "ForceEndpointErrorConfiguration",
        .hls_manifests = "HlsManifests",
        .low_latency_hls_manifests = "LowLatencyHlsManifests",
        .modified_at = "ModifiedAt",
        .mss_manifests = "MssManifests",
        .origin_endpoint_name = "OriginEndpointName",
    };
};
