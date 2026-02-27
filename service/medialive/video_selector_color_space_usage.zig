/// Video Selector Color Space Usage
pub const VideoSelectorColorSpaceUsage = enum {
    fallback,
    force,

    pub const json_field_names = .{
        .fallback = "FALLBACK",
        .force = "FORCE",
    };
};
