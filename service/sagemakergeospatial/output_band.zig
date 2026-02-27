const OutputType = @import("output_type.zig").OutputType;

/// A single EarthObservationJob output band.
pub const OutputBand = struct {
    /// The name of the band.
    band_name: []const u8,

    /// The datatype of the output band.
    output_data_type: OutputType,

    pub const json_field_names = .{
        .band_name = "BandName",
        .output_data_type = "OutputDataType",
    };
};
