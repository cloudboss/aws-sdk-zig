const CdiInputResolution = @import("cdi_input_resolution.zig").CdiInputResolution;

/// Placeholder documentation for CdiInputSpecification
pub const CdiInputSpecification = struct {
    /// Maximum CDI input resolution
    resolution: ?CdiInputResolution,

    pub const json_field_names = .{
        .resolution = "Resolution",
    };
};
