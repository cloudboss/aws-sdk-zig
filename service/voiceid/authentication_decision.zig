const std = @import("std");

pub const AuthenticationDecision = enum {
    accept,
    reject,
    not_enough_speech,
    speaker_not_enrolled,
    speaker_opted_out,
    speaker_id_not_provided,
    speaker_expired,

    pub const json_field_names = .{
        .accept = "ACCEPT",
        .reject = "REJECT",
        .not_enough_speech = "NOT_ENOUGH_SPEECH",
        .speaker_not_enrolled = "SPEAKER_NOT_ENROLLED",
        .speaker_opted_out = "SPEAKER_OPTED_OUT",
        .speaker_id_not_provided = "SPEAKER_ID_NOT_PROVIDED",
        .speaker_expired = "SPEAKER_EXPIRED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .accept => "ACCEPT",
            .reject => "REJECT",
            .not_enough_speech => "NOT_ENOUGH_SPEECH",
            .speaker_not_enrolled => "SPEAKER_NOT_ENROLLED",
            .speaker_opted_out => "SPEAKER_OPTED_OUT",
            .speaker_id_not_provided => "SPEAKER_ID_NOT_PROVIDED",
            .speaker_expired => "SPEAKER_EXPIRED",
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
