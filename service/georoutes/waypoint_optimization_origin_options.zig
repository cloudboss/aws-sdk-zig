/// Origin related options.
pub const WaypointOptimizationOriginOptions = struct {
    /// The Origin Id.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "Id",
    };
};
