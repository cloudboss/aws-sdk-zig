/// Describes a Reserved Instance whose queued purchase was successfully
/// deleted.
pub const SuccessfulQueuedPurchaseDeletion = struct {
    /// The ID of the Reserved Instance.
    reserved_instances_id: ?[]const u8,
};
