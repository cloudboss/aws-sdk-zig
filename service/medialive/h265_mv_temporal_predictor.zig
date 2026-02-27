/// H265 Mv Temporal Predictor
pub const H265MvTemporalPredictor = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
