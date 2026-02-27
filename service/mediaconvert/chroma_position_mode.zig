/// Specify the chroma sample positioning metadata for your H.264 or H.265
/// output. To have MediaConvert automatically determine chroma positioning: We
/// recommend that you keep the default value, Auto. To specify center
/// positioning: Choose Force center. To specify top left positioning: Choose
/// Force top left.
pub const ChromaPositionMode = enum {
    auto,
    force_center,
    force_top_left,

    pub const json_field_names = .{
        .auto = "AUTO",
        .force_center = "FORCE_CENTER",
        .force_top_left = "FORCE_TOP_LEFT",
    };
};
