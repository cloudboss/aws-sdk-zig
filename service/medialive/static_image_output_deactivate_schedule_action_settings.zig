/// Settings for the action to deactivate the image in a specific layer.
pub const StaticImageOutputDeactivateScheduleActionSettings = struct {
    /// The time in milliseconds for the image to fade out. Default is 0 (no
    /// fade-out).
    fade_out: ?i32 = null,

    /// The image overlay layer to deactivate, 0 to 7. Default is 0.
    layer: ?i32 = null,

    /// The name(s) of the output(s) the deactivation should apply to.
    output_names: []const []const u8,

    pub const json_field_names = .{
        .fade_out = "FadeOut",
        .layer = "Layer",
        .output_names = "OutputNames",
    };
};
