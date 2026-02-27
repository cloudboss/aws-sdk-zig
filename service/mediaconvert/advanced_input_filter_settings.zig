const AdvancedInputFilterAddTexture = @import("advanced_input_filter_add_texture.zig").AdvancedInputFilterAddTexture;
const AdvancedInputFilterSharpen = @import("advanced_input_filter_sharpen.zig").AdvancedInputFilterSharpen;

/// Optional settings for Advanced input filter when you set Advanced input
/// filter to Enabled.
pub const AdvancedInputFilterSettings = struct {
    /// Add texture and detail to areas of your input video content that were lost
    /// after applying the Advanced input filter. To adaptively add texture and
    /// reduce softness: Choose Enabled. To not add any texture: Keep the default
    /// value, Disabled. We recommend that you choose Disabled for input video
    /// content that doesn't have texture, including screen recordings, computer
    /// graphics, or cartoons.
    add_texture: ?AdvancedInputFilterAddTexture,

    /// Optionally specify the amount of sharpening to apply when you use the
    /// Advanced input filter. Sharpening adds contrast to the edges of your video
    /// content and can reduce softness. To apply no sharpening: Keep the default
    /// value, Off. To apply a minimal amount of sharpening choose Low, or for the
    /// maximum choose High.
    sharpening: ?AdvancedInputFilterSharpen,

    pub const json_field_names = .{
        .add_texture = "AddTexture",
        .sharpening = "Sharpening",
    };
};
