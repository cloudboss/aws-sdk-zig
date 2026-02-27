const PreloadDataType = @import("preload_data_type.zig").PreloadDataType;

/// The input properties for the preloaded (Synthea) data store.
pub const PreloadDataConfig = struct {
    /// The type of preloaded data. Only Synthea preloaded data is supported.
    preload_data_type: PreloadDataType,

    pub const json_field_names = .{
        .preload_data_type = "PreloadDataType",
    };
};
