const Scte35InputMode = @import("scte_35_input_mode.zig").Scte35InputMode;

/// Scte35Input Schedule Action Settings
pub const Scte35InputScheduleActionSettings = struct {
    /// In fixed mode, enter the name of the input attachment that you want to use
    /// as a SCTE-35 input. (Don't enter the ID of the input.)"
    input_attachment_name_reference: ?[]const u8 = null,

    /// Whether the SCTE-35 input should be the active input or a fixed input.
    mode: Scte35InputMode,

    pub const json_field_names = .{
        .input_attachment_name_reference = "InputAttachmentNameReference",
        .mode = "Mode",
    };
};
