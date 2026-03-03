const std = @import("std");

pub const AnsweringMachineDetectionStatus = enum {
    answered,
    undetected,
    @"error",
    human_answered,
    sit_tone_detected,
    sit_tone_busy,
    sit_tone_invalid_number,
    fax_machine_detected,
    voicemail_beep,
    voicemail_no_beep,
    amd_unresolved,
    amd_unanswered,
    amd_error,
    amd_not_applicable,

    pub const json_field_names = .{
        .answered = "ANSWERED",
        .undetected = "UNDETECTED",
        .@"error" = "ERROR",
        .human_answered = "HUMAN_ANSWERED",
        .sit_tone_detected = "SIT_TONE_DETECTED",
        .sit_tone_busy = "SIT_TONE_BUSY",
        .sit_tone_invalid_number = "SIT_TONE_INVALID_NUMBER",
        .fax_machine_detected = "FAX_MACHINE_DETECTED",
        .voicemail_beep = "VOICEMAIL_BEEP",
        .voicemail_no_beep = "VOICEMAIL_NO_BEEP",
        .amd_unresolved = "AMD_UNRESOLVED",
        .amd_unanswered = "AMD_UNANSWERED",
        .amd_error = "AMD_ERROR",
        .amd_not_applicable = "AMD_NOT_APPLICABLE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .answered => "ANSWERED",
            .undetected => "UNDETECTED",
            .@"error" => "ERROR",
            .human_answered => "HUMAN_ANSWERED",
            .sit_tone_detected => "SIT_TONE_DETECTED",
            .sit_tone_busy => "SIT_TONE_BUSY",
            .sit_tone_invalid_number => "SIT_TONE_INVALID_NUMBER",
            .fax_machine_detected => "FAX_MACHINE_DETECTED",
            .voicemail_beep => "VOICEMAIL_BEEP",
            .voicemail_no_beep => "VOICEMAIL_NO_BEEP",
            .amd_unresolved => "AMD_UNRESOLVED",
            .amd_unanswered => "AMD_UNANSWERED",
            .amd_error => "AMD_ERROR",
            .amd_not_applicable => "AMD_NOT_APPLICABLE",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
