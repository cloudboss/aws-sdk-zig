const EnabledOrDisabledState = @import("enabled_or_disabled_state.zig").EnabledOrDisabledState;

/// Configuration for image extraction.
pub const ImageExtractionConfiguration = struct {
    /// Whether image extraction is enabled or disabled.
    image_extraction_status: EnabledOrDisabledState,

    pub const json_field_names = .{
        .image_extraction_status = "imageExtractionStatus",
    };
};
