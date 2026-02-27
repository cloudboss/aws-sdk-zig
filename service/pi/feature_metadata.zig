const FeatureStatus = @import("feature_status.zig").FeatureStatus;

/// The metadata for a feature. For example, the metadata might indicate that a
/// feature is
/// turned on or off on a specific DB instance.
pub const FeatureMetadata = struct {
    /// The status of the feature on the DB instance. Possible values include the
    /// following:
    ///
    /// * `ENABLED` - The feature is enabled on the instance.
    ///
    /// * `DISABLED` - The feature is disabled on the instance.
    ///
    /// * `UNSUPPORTED` - The feature isn't supported on the instance.
    ///
    /// * `ENABLED_PENDING_REBOOT` - The feature is enabled on the instance but
    ///   requires a reboot to take effect.
    ///
    /// * `DISABLED_PENDING_REBOOT` - The feature is disabled on the instance but
    ///   requires a reboot to take effect.
    ///
    /// * `UNKNOWN` - The feature status couldn't be determined.
    status: ?FeatureStatus,

    pub const json_field_names = .{
        .status = "Status",
    };
};
