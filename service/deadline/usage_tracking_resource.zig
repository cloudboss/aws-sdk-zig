/// The usage details of the allotted budget.
pub const UsageTrackingResource = union(enum) {
    /// The queue ID.
    queue_id: ?[]const u8,

    pub const json_field_names = .{
        .queue_id = "queueId",
    };
};
