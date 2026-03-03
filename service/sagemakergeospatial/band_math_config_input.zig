const CustomIndicesInput = @import("custom_indices_input.zig").CustomIndicesInput;

/// Input structure for the BandMath operation type.
/// Defines Predefined and CustomIndices to be computed using BandMath.
pub const BandMathConfigInput = struct {
    /// CustomIndices that are computed.
    custom_indices: ?CustomIndicesInput = null,

    /// One or many of the supported predefined indices to compute.
    /// Allowed values: `NDVI`, `EVI2`, `MSAVI`,
    /// `NDWI`, `NDMI`, `NDSI`, and `WDRVI`.
    predefined_indices: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .custom_indices = "CustomIndices",
        .predefined_indices = "PredefinedIndices",
    };
};
