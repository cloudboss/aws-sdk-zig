const OperatorResponse = @import("operator_response.zig").OperatorResponse;
const AttachmentStatus = @import("attachment_status.zig").AttachmentStatus;

/// Describes a parameter used to set up an EBS volume in a block device
/// mapping.
pub const EbsInstanceBlockDevice = struct {
    /// The ARN of the Amazon Web Services-managed resource
    /// to which the volume is attached.
    associated_resource: ?[]const u8 = null,

    /// The time stamp when the attachment initiated.
    attach_time: ?i64 = null,

    /// Indicates whether the volume is deleted on instance termination.
    delete_on_termination: ?bool = null,

    /// The index of the EBS card. Some instance types support multiple EBS cards.
    /// The default EBS card index is 0.
    ebs_card_index: ?i32 = null,

    /// The service provider that manages the EBS volume.
    operator: ?OperatorResponse = null,

    /// The attachment state.
    status: ?AttachmentStatus = null,

    /// The ID of the EBS volume.
    volume_id: ?[]const u8 = null,

    /// The ID of the Amazon Web Services account that owns the volume.
    ///
    /// This parameter is returned only for volumes that are attached to
    /// Amazon Web Services-managed resources.
    volume_owner_id: ?[]const u8 = null,
};
