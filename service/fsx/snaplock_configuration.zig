const AutocommitPeriod = @import("autocommit_period.zig").AutocommitPeriod;
const PrivilegedDelete = @import("privileged_delete.zig").PrivilegedDelete;
const SnaplockRetentionPeriod = @import("snaplock_retention_period.zig").SnaplockRetentionPeriod;
const SnaplockType = @import("snaplock_type.zig").SnaplockType;

/// Specifies the SnapLock configuration for an FSx for ONTAP SnapLock volume.
pub const SnaplockConfiguration = struct {
    /// Enables or disables the audit log volume for an FSx for ONTAP SnapLock
    /// volume. The default
    /// value is `false`. If you set `AuditLogVolume` to `true`, the SnapLock volume
    /// is
    /// created as an audit log volume. The minimum retention period for an audit
    /// log volume is six months.
    ///
    /// For more information, see
    /// [
    /// SnapLock audit log
    /// volumes](https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/how-snaplock-works.html#snaplock-audit-log-volume).
    audit_log_volume: ?bool = null,

    /// The configuration object for setting the autocommit period of files in an
    /// FSx for ONTAP SnapLock volume.
    autocommit_period: ?AutocommitPeriod = null,

    /// Enables, disables, or permanently disables privileged delete on an FSx for
    /// ONTAP SnapLock
    /// Enterprise volume. Enabling privileged delete allows SnapLock administrators
    /// to delete write once, read
    /// many (WORM) files even
    /// if they have active retention periods. `PERMANENTLY_DISABLED` is a terminal
    /// state.
    /// If privileged delete is permanently disabled on a SnapLock volume, you can't
    /// re-enable it. The default
    /// value is `DISABLED`.
    ///
    /// For more information, see [Privileged
    /// delete](https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/snaplock-enterprise.html#privileged-delete).
    privileged_delete: ?PrivilegedDelete = null,

    /// Specifies the retention period of an FSx for ONTAP SnapLock volume.
    retention_period: ?SnaplockRetentionPeriod = null,

    /// Specifies the retention mode of an FSx for ONTAP SnapLock volume. After it
    /// is set, it can't be changed.
    /// You can choose one of the following retention modes:
    ///
    /// * `COMPLIANCE`: Files transitioned to write once, read many (WORM) on a
    ///   Compliance volume can't be deleted
    /// until their retention periods expire. This retention mode is used to address
    /// government or industry-specific mandates or to protect
    /// against ransomware attacks. For more information,
    /// see [SnapLock
    /// Compliance](https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/snaplock-compliance.html).
    ///
    /// * `ENTERPRISE`: Files transitioned to WORM on an Enterprise volume can be
    ///   deleted by authorized users
    /// before their retention periods expire using privileged delete. This
    /// retention mode is used to advance an organization's data integrity
    /// and internal compliance or to test retention settings before using SnapLock
    /// Compliance. For more information, see
    /// [SnapLock
    /// Enterprise](https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/snaplock-enterprise.html).
    snaplock_type: ?SnaplockType = null,

    /// Enables or disables volume-append mode
    /// on an FSx for ONTAP SnapLock volume. Volume-append mode allows you to
    /// create WORM-appendable files and write data to them incrementally.
    /// The default value is `false`.
    ///
    /// For more information, see [Volume-append
    /// mode](https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/worm-state.html#worm-state-append).
    volume_append_mode_enabled: ?bool = null,

    pub const json_field_names = .{
        .audit_log_volume = "AuditLogVolume",
        .autocommit_period = "AutocommitPeriod",
        .privileged_delete = "PrivilegedDelete",
        .retention_period = "RetentionPeriod",
        .snaplock_type = "SnaplockType",
        .volume_append_mode_enabled = "VolumeAppendModeEnabled",
    };
};
