const SelfUpgradeStatus = @import("self_upgrade_status.zig").SelfUpgradeStatus;

/// The self-upgrade configuration for the Quick account.
pub const SelfUpgradeConfiguration = struct {
    /// Status set for the self-upgrade configuration for the Quick account. It can
    /// contain the following values:
    ///
    /// * `AUTO_APPROVAL`: All the self-upgrade requests will be auto approved.
    ///
    /// * `ADMIN_APPROVAL`: All the self-upgrade requests will require admin
    ///   approval.
    self_upgrade_status: ?SelfUpgradeStatus = null,

    pub const json_field_names = .{
        .self_upgrade_status = "SelfUpgradeStatus",
    };
};
