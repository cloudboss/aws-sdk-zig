/// The static data configuration of the reference line data configuration.
pub const ReferenceLineStaticDataConfiguration = struct {
    /// The double input of the static data.
    value: f64 = 0,

    pub const json_field_names = .{
        .value = "Value",
    };
};
