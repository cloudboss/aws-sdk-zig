const InputClippingSettings = @import("input_clipping_settings.zig").InputClippingSettings;

/// Settings for the "switch input" action: to switch from ingesting one input
/// to ingesting another input.
pub const InputSwitchScheduleActionSettings = struct {
    /// The name of the input attachment (not the name of the input!) to switch to.
    /// The name is specified in the channel configuration.
    input_attachment_name_reference: []const u8,

    /// Settings to let you create a clip of the file input, in order to set up the
    /// input to ingest only a portion of the file.
    input_clipping_settings: ?InputClippingSettings,

    /// The value for the variable portion of the URL for the dynamic input, for
    /// this instance of the input. Each time you use the same dynamic input in an
    /// input switch action, you can provide a different value, in order to connect
    /// the input to a different content source.
    url_path: ?[]const []const u8,

    pub const json_field_names = .{
        .input_attachment_name_reference = "InputAttachmentNameReference",
        .input_clipping_settings = "InputClippingSettings",
        .url_path = "UrlPath",
    };
};
