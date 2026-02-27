/// The WorkerBlock data structure represents a Worker who has
/// been blocked. It has two elements: the WorkerId and the Reason for
/// the block.
pub const WorkerBlock = struct {
    /// A message explaining the reason the Worker was blocked.
    reason: ?[]const u8,

    /// The ID of the Worker who accepted the HIT.
    worker_id: ?[]const u8,

    pub const json_field_names = .{
        .reason = "Reason",
        .worker_id = "WorkerId",
    };
};
