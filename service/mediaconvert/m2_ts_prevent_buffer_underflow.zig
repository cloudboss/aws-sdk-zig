/// Specify whether MediaConvert automatically attempts to prevent decoder
/// buffer underflows in your transport stream output. Use if you are seeing
/// decoder buffer underflows in your output and are unable to increase your
/// transport stream's bitrate. For most workflows: We recommend that you keep
/// the default value, Disabled. To prevent decoder buffer underflows in your
/// output, when possible: Choose Enabled. Note that if MediaConvert prevents a
/// decoder buffer underflow in your output, output video quality is reduced and
/// your job will take longer to complete.
pub const M2tsPreventBufferUnderflow = enum {
    disabled,
    enabled,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .enabled = "ENABLED",
    };
};
