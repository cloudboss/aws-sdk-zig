/// The status of zonal shift configuration for the cluster
pub const ZonalShiftConfigResponse = struct {
    /// Whether the zonal shift is enabled.
    enabled: ?bool = null,

    pub const json_field_names = .{
        .enabled = "enabled",
    };
};
