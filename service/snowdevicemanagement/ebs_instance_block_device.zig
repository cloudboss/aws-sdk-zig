const AttachmentStatus = @import("attachment_status.zig").AttachmentStatus;

/// Describes a parameter used to set up an Amazon Elastic Block Store (Amazon
/// EBS) volume
/// in a block device mapping.
pub const EbsInstanceBlockDevice = struct {
    /// When the attachment was initiated.
    attach_time: ?i64,

    /// A value that indicates whether the volume is deleted on instance
    /// termination.
    delete_on_termination: ?bool,

    /// The attachment state.
    status: ?AttachmentStatus,

    /// The ID of the Amazon EBS volume.
    volume_id: ?[]const u8,

    pub const json_field_names = .{
        .attach_time = "attachTime",
        .delete_on_termination = "deleteOnTermination",
        .status = "status",
        .volume_id = "volumeId",
    };
};
