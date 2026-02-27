const TrainedModelExportsMaxSizeUnitType = @import("trained_model_exports_max_size_unit_type.zig").TrainedModelExportsMaxSizeUnitType;

/// The maximum size of the trained model metrics that can be exported. If the
/// trained model metrics dataset is larger than this value, it will not be
/// exported.
pub const TrainedModelExportsMaxSize = struct {
    /// The unit of measurement for the data size.
    unit: TrainedModelExportsMaxSizeUnitType,

    /// The maximum size of the dataset to export.
    value: f64,

    pub const json_field_names = .{
        .unit = "unit",
        .value = "value",
    };
};
