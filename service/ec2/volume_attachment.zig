const VolumeAttachmentState = @import("volume_attachment_state.zig").VolumeAttachmentState;

/// Describes volume attachment details.
pub const VolumeAttachment = struct {
    /// The ARN of the Amazon Web Services-managed resource
    /// to which the volume is attached.
    associated_resource: ?[]const u8 = null,

    /// The time stamp when the attachment initiated.
    attach_time: ?i64 = null,

    /// Indicates whether the EBS volume is deleted on instance termination.
    delete_on_termination: ?bool = null,

    /// The device name.
    ///
    /// If the volume is attached to an Amazon Web Services-managed resource, this
    /// parameter
    /// returns `null`.
    device: ?[]const u8 = null,

    /// The index of the EBS card. Some instance types support multiple EBS cards.
    /// The default EBS card index is 0.
    ebs_card_index: ?i32 = null,

    /// The ID of the instance.
    ///
    /// If the volume is attached to an Amazon Web Services-managed resource, this
    /// parameter
    /// returns `null`.
    instance_id: ?[]const u8 = null,

    /// The service principal of the Amazon Web Services service that owns the
    /// underlying
    /// resource to which the volume is attached.
    ///
    /// This parameter is returned only for volumes that are attached to
    /// Amazon Web Services-managed resources.
    instance_owning_service: ?[]const u8 = null,

    /// The attachment state of the volume.
    state: ?VolumeAttachmentState = null,

    /// The ID of the volume.
    volume_id: ?[]const u8 = null,
};
