const OutputResolutionStackInput = @import("output_resolution_stack_input.zig").OutputResolutionStackInput;

/// The input structure for Stacking Operation.
pub const StackConfigInput = struct {
    /// The structure representing output
    /// resolution (in target georeferenced units) of the
    /// result of stacking operation.
    output_resolution: ?OutputResolutionStackInput = null,

    /// A list of bands to be stacked in the specified order. When the parameter is
    /// not provided, all the available bands in the data collection are stacked in
    /// the alphabetical order of their asset names.
    target_bands: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .output_resolution = "OutputResolution",
        .target_bands = "TargetBands",
    };
};
