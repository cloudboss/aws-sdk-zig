const AutocommitPeriod = @import("autocommit_period.zig").AutocommitPeriod;
const PrivilegedDelete = @import("privileged_delete.zig").PrivilegedDelete;
const SnaplockRetentionPeriod = @import("snaplock_retention_period.zig").SnaplockRetentionPeriod;

/// Updates the SnapLock configuration for an existing FSx for ONTAP volume.
pub const UpdateSnaplockConfiguration = struct {
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
    /// For more information, see
    /// [Privileged
    /// delete](https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/snaplock-enterprise.html#privileged-delete).
    privileged_delete: ?PrivilegedDelete = null,

    /// Specifies the retention period of an FSx for ONTAP SnapLock volume.
    retention_period: ?SnaplockRetentionPeriod = null,

    /// Enables or disables volume-append mode
    /// on an FSx for ONTAP SnapLock volume. Volume-append mode allows you to
    /// create WORM-appendable files and write data to them incrementally. The
    /// default value is `false`.
    ///
    /// For more information, see [Volume-append
    /// mode](https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/worm-state.html#worm-state-append).
    volume_append_mode_enabled: ?bool = null,

    pub const json_field_names = .{
        .audit_log_volume = "AuditLogVolume",
        .autocommit_period = "AutocommitPeriod",
        .privileged_delete = "PrivilegedDelete",
        .retention_period = "RetentionPeriod",
        .volume_append_mode_enabled = "VolumeAppendModeEnabled",
    };
};
