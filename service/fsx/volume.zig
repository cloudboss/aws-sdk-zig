const AdministrativeAction = @import("administrative_action.zig").AdministrativeAction;
const VolumeLifecycle = @import("volume_lifecycle.zig").VolumeLifecycle;
const LifecycleTransitionReason = @import("lifecycle_transition_reason.zig").LifecycleTransitionReason;
const OntapVolumeConfiguration = @import("ontap_volume_configuration.zig").OntapVolumeConfiguration;
const OpenZFSVolumeConfiguration = @import("open_zfs_volume_configuration.zig").OpenZFSVolumeConfiguration;
const Tag = @import("tag.zig").Tag;
const VolumeType = @import("volume_type.zig").VolumeType;

/// Describes an Amazon FSx volume.
pub const Volume = struct {
    /// A list of administrative actions for the volume that are in process or
    /// waiting to be processed.
    /// Administrative actions describe changes to the volume that you have
    /// initiated using
    /// the `UpdateVolume` action.
    administrative_actions: ?[]const AdministrativeAction = null,

    creation_time: ?i64 = null,

    file_system_id: ?[]const u8 = null,

    /// The lifecycle status of the volume.
    ///
    /// * `AVAILABLE` - The volume is fully available for
    /// use.
    ///
    /// * `CREATED` - The volume has been created.
    ///
    /// * `CREATING` - Amazon FSx is creating the new volume.
    ///
    /// * `DELETING` - Amazon FSx is deleting an existing
    /// volume.
    ///
    /// * `FAILED` - Amazon FSx was unable to create the
    /// volume.
    ///
    /// * `MISCONFIGURED` - The volume is in a failed but recoverable
    /// state.
    ///
    /// * `PENDING` - Amazon FSx hasn't started creating the
    /// volume.
    lifecycle: ?VolumeLifecycle = null,

    /// The reason why the volume lifecycle status changed.
    lifecycle_transition_reason: ?LifecycleTransitionReason = null,

    /// The name of the volume.
    name: ?[]const u8 = null,

    ontap_configuration: ?OntapVolumeConfiguration = null,

    /// The configuration of an Amazon FSx for OpenZFS volume.
    open_zfs_configuration: ?OpenZFSVolumeConfiguration = null,

    resource_arn: ?[]const u8 = null,

    tags: ?[]const Tag = null,

    /// The system-generated, unique ID of the volume.
    volume_id: ?[]const u8 = null,

    /// The type of the volume.
    volume_type: ?VolumeType = null,

    pub const json_field_names = .{
        .administrative_actions = "AdministrativeActions",
        .creation_time = "CreationTime",
        .file_system_id = "FileSystemId",
        .lifecycle = "Lifecycle",
        .lifecycle_transition_reason = "LifecycleTransitionReason",
        .name = "Name",
        .ontap_configuration = "OntapConfiguration",
        .open_zfs_configuration = "OpenZFSConfiguration",
        .resource_arn = "ResourceARN",
        .tags = "Tags",
        .volume_id = "VolumeId",
        .volume_type = "VolumeType",
    };
};
