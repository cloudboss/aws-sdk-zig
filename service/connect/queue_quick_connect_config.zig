/// Contains information about a queue for a quick connect. The flow must be of
/// type Transfer to Queue.
pub const QueueQuickConnectConfig = struct {
    /// The identifier of the flow.
    contact_flow_id: []const u8,

    /// The identifier for the queue.
    queue_id: []const u8,

    pub const json_field_names = .{
        .contact_flow_id = "ContactFlowId",
        .queue_id = "QueueId",
    };
};
