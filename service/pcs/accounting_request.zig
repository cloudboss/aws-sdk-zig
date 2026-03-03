const AccountingMode = @import("accounting_mode.zig").AccountingMode;

/// The accounting configuration includes configurable settings for Slurm
/// accounting. It's a property of the **ClusterSlurmConfiguration** object.
pub const AccountingRequest = struct {
    /// The default value for all purge settings for `slurmdbd.conf`. For more
    /// information, see the [slurmdbd.conf documentation at
    /// SchedMD](https://slurm.schedmd.com/slurmdbd.conf.html).
    ///
    /// The default value for `defaultPurgeTimeInDays` is `-1`.
    ///
    /// A value of `-1` means there is no purge time and records persist as long as
    /// the cluster exists.
    ///
    /// `0` isn't a valid value.
    default_purge_time_in_days: ?i32 = null,

    /// The default value for `mode` is `NONE`. A value of `STANDARD` means Slurm
    /// accounting is enabled.
    mode: AccountingMode,

    pub const json_field_names = .{
        .default_purge_time_in_days = "defaultPurgeTimeInDays",
        .mode = "mode",
    };
};
