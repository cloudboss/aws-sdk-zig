const std = @import("std");

pub const DrmSystem = enum {
    clear_key_aes_128,
    fairplay,
    playready,
    widevine,
    irdeto,

    pub const json_field_names = .{
        .clear_key_aes_128 = "CLEAR_KEY_AES_128",
        .fairplay = "FAIRPLAY",
        .playready = "PLAYREADY",
        .widevine = "WIDEVINE",
        .irdeto = "IRDETO",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .clear_key_aes_128 => "CLEAR_KEY_AES_128",
            .fairplay => "FAIRPLAY",
            .playready => "PLAYREADY",
            .widevine => "WIDEVINE",
            .irdeto => "IRDETO",
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
