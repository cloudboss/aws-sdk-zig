pub const NotebookInstanceAcceleratorType = enum {
    ml_eia1_medium,
    ml_eia1_large,
    ml_eia1_xlarge,
    ml_eia2_medium,
    ml_eia2_large,
    ml_eia2_xlarge,

    pub const json_field_names = .{
        .ml_eia1_medium = "ML_EIA1_MEDIUM",
        .ml_eia1_large = "ML_EIA1_LARGE",
        .ml_eia1_xlarge = "ML_EIA1_XLARGE",
        .ml_eia2_medium = "ML_EIA2_MEDIUM",
        .ml_eia2_large = "ML_EIA2_LARGE",
        .ml_eia2_xlarge = "ML_EIA2_XLARGE",
    };
};
