const AttachmentEnaSrdSpecification = @import("attachment_ena_srd_specification.zig").AttachmentEnaSrdSpecification;
const AttachmentStatus = @import("attachment_status.zig").AttachmentStatus;

/// Describes a network interface attachment.
pub const NetworkInterfaceAttachment = struct {
    /// The ID of the network interface attachment.
    attachment_id: ?[]const u8,

    /// The timestamp indicating when the attachment initiated.
    attach_time: ?i64,

    /// Indicates whether the network interface is deleted when the instance is
    /// terminated.
    delete_on_termination: ?bool,

    /// The device index of the network interface attachment on the instance.
    device_index: ?i32,

    /// The number of ENA queues created with the instance.
    ena_queue_count: ?i32,

    /// Configures ENA Express for the network interface that this action attaches
    /// to the
    /// instance.
    ena_srd_specification: ?AttachmentEnaSrdSpecification,

    /// The ID of the instance.
    instance_id: ?[]const u8,

    /// The Amazon Web Services account ID of the owner of the instance.
    instance_owner_id: ?[]const u8,

    /// The index of the network card.
    network_card_index: ?i32,

    /// The attachment state.
    status: ?AttachmentStatus,
};
