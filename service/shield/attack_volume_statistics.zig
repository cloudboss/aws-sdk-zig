/// Statistics objects for the various data types in AttackVolume.
pub const AttackVolumeStatistics = struct {
    /// The maximum attack volume observed for the given unit.
    max: f64 = 0,

    pub const json_field_names = .{
        .max = "Max",
    };
};
