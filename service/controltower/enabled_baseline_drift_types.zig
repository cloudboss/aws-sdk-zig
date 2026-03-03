const EnabledBaselineInheritanceDrift = @import("enabled_baseline_inheritance_drift.zig").EnabledBaselineInheritanceDrift;

/// The types of drift that can be detected for an enabled baseline.
///
/// * Amazon Web Services Control Tower detects inheritance drift on the enabled
///   baselines that target OUs: `AWSControlTowerBaseline` and `BackupBaseline`.
/// * Amazon Web Services Control Tower does not detect drift on the baselines
///   that apply to your landing zone: `IdentityCenterBaseline`,
///   `AuditBaseline`, `LogArchiveBaseline`, `BackupCentralVaultBaseline`, or
///   `BackupAdminBaseline`. For more information, see [Types of
///   baselines](https://docs.aws.amazon.com/controltower/latest/userguide/types-of-baselines.html).
///
/// Baselines enabled on an OU are inherited by its member accounts as child
/// `EnabledBaseline` resources. The baseline on the OU serves as the parent
/// `EnabledBaseline`, which governs the configuration of each child
/// `EnabledBaseline`.
///
/// If the baseline configuration of a member account in an OU does not match
/// the configuration of the parent OU, the parent and child baseline is in a
/// state of inheritance drift. This drift could occur in the
/// `AWSControlTowerBaseline` or the `BackupBaseline` related to that account.
pub const EnabledBaselineDriftTypes = struct {
    /// At least one account within the target OU does not match the baseline
    /// configuration defined on that OU. An account is in inheritance drift when it
    /// does not match the configuration of a parent OU, possibly a new parent OU,
    /// if the account is moved.
    inheritance: ?EnabledBaselineInheritanceDrift = null,

    pub const json_field_names = .{
        .inheritance = "inheritance",
    };
};
