const AttachmentStatus = @import("attachment_status.zig").AttachmentStatus;

/// Describes the attachment of a secondary interface to an instance.
pub const InstanceSecondaryInterfaceAttachment = struct {
    /// The ID of the attachment.
    attachment_id: ?[]const u8 = null,

    /// The timestamp when the attachment was created.
    attach_time: ?i64 = null,

    /// Indicates whether the secondary interface is deleted when the instance is
    /// terminated.
    ///
    /// The only supported value for this field is `true`.
    delete_on_termination: ?bool = null,

    /// The device index of the secondary interface.
    device_index: ?i32 = null,

    /// The index of the network card.
    network_card_index: ?i32 = null,

    /// The attachment state.
    status: ?AttachmentStatus = null,
};
