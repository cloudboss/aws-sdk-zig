const SlotMigration = @import("slot_migration.zig").SlotMigration;

/// The status of the online resharding
pub const ReshardingStatus = struct {
    /// The status of the online resharding slot migration
    slot_migration: ?SlotMigration,

    pub const json_field_names = .{
        .slot_migration = "SlotMigration",
    };
};
