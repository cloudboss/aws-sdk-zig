const std = @import("std");

/// The audio filler identifier played during speech-to-speech
/// interactions. Supported values include melody and typing variants such
/// as `MELODY_CHIPPER_CHIME`, `MELODY_CURIOUS_CRAWL`,
/// `MELODY_RISING_RIPPLE`, `MELODY_PATIENT_PING`,
/// `MELODY_PONDERING_PONG`, `TYPING_KINETIC_KEYS`,
/// and `TYPING_QUIET_QWERTY`.
pub const AudioFillerType = enum {
    melody_chipper_chime,
    melody_curious_crawl,
    melody_rising_ripple,
    melody_patient_ping,
    melody_pondering_pong,
    typing_kinetic_keys,
    typing_quiet_qwerty,

    pub const json_field_names = .{
        .melody_chipper_chime = "MELODY_CHIPPER_CHIME",
        .melody_curious_crawl = "MELODY_CURIOUS_CRAWL",
        .melody_rising_ripple = "MELODY_RISING_RIPPLE",
        .melody_patient_ping = "MELODY_PATIENT_PING",
        .melody_pondering_pong = "MELODY_PONDERING_PONG",
        .typing_kinetic_keys = "TYPING_KINETIC_KEYS",
        .typing_quiet_qwerty = "TYPING_QUIET_QWERTY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .melody_chipper_chime => "MELODY_CHIPPER_CHIME",
            .melody_curious_crawl => "MELODY_CURIOUS_CRAWL",
            .melody_rising_ripple => "MELODY_RISING_RIPPLE",
            .melody_patient_ping => "MELODY_PATIENT_PING",
            .melody_pondering_pong => "MELODY_PONDERING_PONG",
            .typing_kinetic_keys => "TYPING_KINETIC_KEYS",
            .typing_quiet_qwerty => "TYPING_QUIET_QWERTY",
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
