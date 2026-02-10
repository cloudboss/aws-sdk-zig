/// Describes an attachment change.
pub const NetworkInterfaceAttachmentChanges = struct {
    /// The ID of the network interface attachment.
    attachment_id: ?[]const u8,

    /// The default number of the ENA queues.
    default_ena_queue_count: ?bool,

    /// Indicates whether the network interface is deleted when the instance is
    /// terminated.
    delete_on_termination: ?bool,

    /// The number of ENA queues to be created with the instance.
    ena_queue_count: ?i32,
};
