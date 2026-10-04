/// Content light level information (CTA-861.3). Describes the light level
/// characteristics of the content.
pub const ContentLightLevel = struct {
    /// Maximum content light level (MaxCLL), in cd/m².
    max_content_light_level: ?i32 = null,

    /// Maximum frame-average light level (MaxFALL), in cd/m².
    max_frame_average_light_level: ?i32 = null,

    pub const json_field_names = .{
        .max_content_light_level = "MaxContentLightLevel",
        .max_frame_average_light_level = "MaxFrameAverageLightLevel",
    };
};
