const ComputeCapacityStatus = @import("compute_capacity_status.zig").ComputeCapacityStatus;
const DomainJoinInfo = @import("domain_join_info.zig").DomainJoinInfo;
const FleetError = @import("fleet_error.zig").FleetError;
const FleetType = @import("fleet_type.zig").FleetType;
const PlatformType = @import("platform_type.zig").PlatformType;
const VolumeConfig = @import("volume_config.zig").VolumeConfig;
const S3Location = @import("s3_location.zig").S3Location;
const FleetState = @import("fleet_state.zig").FleetState;
const StreamView = @import("stream_view.zig").StreamView;
const VpcConfig = @import("vpc_config.zig").VpcConfig;

/// Describes a fleet.
pub const Fleet = struct {
    /// The Amazon Resource Name (ARN) for the fleet.
    arn: []const u8,

    /// The capacity status for the fleet.
    compute_capacity_status: ComputeCapacityStatus,

    /// The time the fleet was created.
    created_time: ?i64 = null,

    /// The description to display.
    description: ?[]const u8 = null,

    /// The amount of time that a streaming session remains active after users
    /// disconnect. If they try to reconnect to the streaming session after a
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

    /// Indicates whether default internet access is enabled for the fleet.
    enable_default_internet_access: ?bool = null,

    /// The fleet errors.
    fleet_errors: ?[]const FleetError = null,

    /// The fleet type.
    ///
    /// **ALWAYS_ON**
    ///
    /// Provides users with instant-on access to their apps.
    /// You are charged for all running instances in your fleet, even if no users
    /// are streaming apps.
    ///
    /// **ON_DEMAND**
    ///
    /// Provide users with access to applications after they connect, which takes
    /// one to two minutes.
    /// You are charged for instance streaming when users are connected and a
    /// small hourly fee for instances that are not streaming apps.
    fleet_type: ?FleetType = null,

    /// The ARN of the IAM role that is applied to the fleet. To assume a role, the
    /// fleet instance calls the AWS Security Token Service (STS) `AssumeRole` API
    /// operation and passes the ARN of the role to use. The operation creates a new
    /// session with temporary credentials. WorkSpaces Applications retrieves the
    /// temporary credentials and creates the **appstream_machine_role** credential
    /// profile on the instance.
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

    /// The ARN for the public, private, or shared image.
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
    instance_type: []const u8,

    /// The maximum number of concurrent sessions for the fleet.
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
    /// Specify a value between 600 and 360000.
    max_user_duration_in_seconds: ?i32 = null,

    /// The name of the fleet.
    name: []const u8,

    /// The platform of the fleet.
    platform: ?PlatformType = null,

    /// The current configuration of the root volume for fleet instances, including
    /// the storage size in GB.
    root_volume_config: ?VolumeConfig = null,

    /// The S3 location of the session scripts configuration zip file. This only
    /// applies to Elastic fleets.
    session_script_s3_location: ?S3Location = null,

    /// The current state for the fleet.
    state: FleetState,

    /// The WorkSpaces Applications view that is displayed to your users when they
    /// stream from the fleet. When `APP` is specified, only the windows of
    /// applications opened by users display. When `DESKTOP` is specified, the
    /// standard desktop that is provided by the operating system displays.
    ///
    /// The default value is `APP`.
    stream_view: ?StreamView = null,

    /// The USB device filter strings associated with the fleet.
    usb_device_filter_strings: ?[]const []const u8 = null,

    /// The VPC configuration for the fleet.
    vpc_config: ?VpcConfig = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .compute_capacity_status = "ComputeCapacityStatus",
        .created_time = "CreatedTime",
        .description = "Description",
        .disconnect_timeout_in_seconds = "DisconnectTimeoutInSeconds",
        .display_name = "DisplayName",
        .domain_join_info = "DomainJoinInfo",
        .enable_default_internet_access = "EnableDefaultInternetAccess",
        .fleet_errors = "FleetErrors",
        .fleet_type = "FleetType",
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
        .state = "State",
        .stream_view = "StreamView",
        .usb_device_filter_strings = "UsbDeviceFilterStrings",
        .vpc_config = "VpcConfig",
    };
};
