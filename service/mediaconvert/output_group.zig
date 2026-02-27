const AutomatedEncodingSettings = @import("automated_encoding_settings.zig").AutomatedEncodingSettings;
const OutputGroupSettings = @import("output_group_settings.zig").OutputGroupSettings;
const Output = @import("output.zig").Output;

/// Group of outputs
pub const OutputGroup = struct {
    /// Use automated encoding to have MediaConvert choose your encoding settings
    /// for you, based on characteristics of your input video.
    automated_encoding_settings: ?AutomatedEncodingSettings,

    /// Use Custom Group Name to specify a name for the output group. This value is
    /// displayed on the console and can make your job settings JSON more
    /// human-readable. It does not affect your outputs. Use up to twelve characters
    /// that are either letters, numbers, spaces, or underscores.
    custom_name: ?[]const u8,

    /// Name of the output group
    name: ?[]const u8,

    /// Output Group settings, including type
    output_group_settings: ?OutputGroupSettings,

    /// This object holds groups of encoding settings, one group of settings per
    /// output.
    outputs: ?[]const Output,

    pub const json_field_names = .{
        .automated_encoding_settings = "AutomatedEncodingSettings",
        .custom_name = "CustomName",
        .name = "Name",
        .output_group_settings = "OutputGroupSettings",
        .outputs = "Outputs",
    };
};
