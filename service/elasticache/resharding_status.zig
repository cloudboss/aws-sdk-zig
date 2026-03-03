const SlotMigration = @import("slot_migration.zig").SlotMigration;

/// The status of an online resharding operation.
pub const ReshardingStatus = struct {
    /// Represents the progress of an online resharding operation.
    slot_migration: ?SlotMigration = null,
};
