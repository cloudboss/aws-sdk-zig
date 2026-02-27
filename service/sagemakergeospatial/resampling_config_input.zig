const AlgorithmNameResampling = @import("algorithm_name_resampling.zig").AlgorithmNameResampling;
const OutputResolutionResamplingInput = @import("output_resolution_resampling_input.zig").OutputResolutionResamplingInput;

/// The structure representing input for resampling operation.
pub const ResamplingConfigInput = struct {
    /// The name of the algorithm used for resampling.
    algorithm_name: ?AlgorithmNameResampling,

    /// The structure representing output
    /// resolution (in target georeferenced units) of the result of resampling
    /// operation.
    output_resolution: OutputResolutionResamplingInput,

    /// Bands used in the operation. If no target bands are specified, it uses all
    /// bands available in the input.
    target_bands: ?[]const []const u8,

    pub const json_field_names = .{
        .algorithm_name = "AlgorithmName",
        .output_resolution = "OutputResolution",
        .target_bands = "TargetBands",
    };
};
