/// Provides information about index capacity configuration.
pub const IndexCapacityConfiguration = struct {
    /// The number of storage units configured for an Amazon Q Business index.
    units: ?i32 = null,

    pub const json_field_names = .{
        .units = "units",
    };
};
