const EnabledOrDisabledState = @import("enabled_or_disabled_state.zig").EnabledOrDisabledState;

/// Configuration for deletion protection.
pub const DeletionProtectionConfiguration = struct {
    /// Enable or disable deletion protection for the connector.
    deletion_protection_status: EnabledOrDisabledState,

    /// The threshold is the maximum percentage of documents that a sync job can
    /// delete from your index. If a sync would delete more than this percentage,
    /// the sync skips its delete phase, leaving your indexed documents in place.
    /// Not supported for the Custom connector.
    deletion_protection_threshold: i32 = 15,

    pub const json_field_names = .{
        .deletion_protection_status = "deletionProtectionStatus",
        .deletion_protection_threshold = "deletionProtectionThreshold",
    };
};
