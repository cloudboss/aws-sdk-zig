/// The logarithmic axis scale setup.
pub const AxisLogarithmicScale = struct {
    /// The base setup of a logarithmic axis scale.
    base: ?f64,

    pub const json_field_names = .{
        .base = "Base",
    };
};
