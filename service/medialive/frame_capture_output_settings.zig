/// Frame Capture Output Settings
pub const FrameCaptureOutputSettings = struct {
    /// Required if the output group contains more than one output. This modifier
    /// forms part of the output file name.
    name_modifier: ?[]const u8,

    pub const json_field_names = .{
        .name_modifier = "NameModifier",
    };
};
