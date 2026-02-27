/// The configuration for zonal shift for the cluster.
pub const ZonalShiftConfigRequest = struct {
    /// If zonal shift is enabled, Amazon Web Services configures zonal autoshift
    /// for the cluster.
    enabled: ?bool,

    pub const json_field_names = .{
        .enabled = "enabled",
    };
};
