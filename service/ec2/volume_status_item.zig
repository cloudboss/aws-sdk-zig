const VolumeStatusAction = @import("volume_status_action.zig").VolumeStatusAction;
const VolumeStatusAttachmentStatus = @import("volume_status_attachment_status.zig").VolumeStatusAttachmentStatus;
const VolumeStatusEvent = @import("volume_status_event.zig").VolumeStatusEvent;
const InitializationStatusDetails = @import("initialization_status_details.zig").InitializationStatusDetails;
const VolumeStatusInfo = @import("volume_status_info.zig").VolumeStatusInfo;

/// Describes the volume status.
pub const VolumeStatusItem = struct {
    /// The details of the operation.
    actions: ?[]const VolumeStatusAction = null,

    /// Information about the instances to which the volume is attached.
    attachment_statuses: ?[]const VolumeStatusAttachmentStatus = null,

    /// The Availability Zone of the volume.
    availability_zone: ?[]const u8 = null,

    /// The ID of the Availability Zone.
    availability_zone_id: ?[]const u8 = null,

    /// A list of events associated with the volume.
    events: ?[]const VolumeStatusEvent = null,

    /// Information about the volume initialization. It can take up to 5 minutes
    /// for the volume initialization information to be updated.
    ///
    /// Only available for volumes created from snapshots. Not available for empty
    /// volumes created without a snapshot.
    ///
    /// For more information, see
    /// [
    /// Initialize Amazon EBS
    /// volumes](https://docs.aws.amazon.com/ebs/latest/userguide/initalize-volume.html).
    initialization_status_details: ?InitializationStatusDetails = null,

    /// The Amazon Resource Name (ARN) of the Outpost.
    outpost_arn: ?[]const u8 = null,

    /// The volume ID.
    volume_id: ?[]const u8 = null,

    /// The volume status.
    volume_status: ?VolumeStatusInfo = null,
};
