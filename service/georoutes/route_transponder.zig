/// Transponders for which this toll can be applied.
pub const RouteTransponder = struct {
    /// Names of the toll system collecting the toll.
    system_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .system_name = "SystemName",
    };
};
