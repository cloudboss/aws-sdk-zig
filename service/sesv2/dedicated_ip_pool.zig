const ScalingMode = @import("scaling_mode.zig").ScalingMode;

/// Contains information about a dedicated IP pool.
pub const DedicatedIpPool = struct {
    /// The name of the dedicated IP pool.
    pool_name: []const u8,

    /// The type of the dedicated IP pool.
    ///
    /// * `STANDARD` – A dedicated IP pool where you can
    /// control which IPs are part of the pool.
    ///
    /// * `MANAGED` – A dedicated IP pool where the reputation and
    /// number of IPs are automatically managed by Amazon SES.
    scaling_mode: ScalingMode,

    pub const json_field_names = .{
        .pool_name = "PoolName",
        .scaling_mode = "ScalingMode",
    };
};
