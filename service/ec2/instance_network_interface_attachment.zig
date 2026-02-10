const InstanceAttachmentEnaSrdSpecification = @import("instance_attachment_ena_srd_specification.zig").InstanceAttachmentEnaSrdSpecification;
const AttachmentStatus = @import("attachment_status.zig").AttachmentStatus;

/// Describes a network interface attachment.
pub const InstanceNetworkInterfaceAttachment = struct {
    /// The ID of the network interface attachment.
    attachment_id: ?[]const u8,

    /// The time stamp when the attachment initiated.
    attach_time: ?i64,

    /// Indicates whether the network interface is deleted when the instance is
    /// terminated.
    delete_on_termination: ?bool,

    /// The index of the device on the instance for the network interface
    /// attachment.
    device_index: ?i32,

    /// The number of ENA queues created with the instance.
    ena_queue_count: ?i32,

    /// Contains the ENA Express settings for the network interface that's attached
    /// to
    /// the instance.
    ena_srd_specification: ?InstanceAttachmentEnaSrdSpecification,

    /// The index of the network card.
    network_card_index: ?i32,

    /// The attachment state.
    status: ?AttachmentStatus,
};
