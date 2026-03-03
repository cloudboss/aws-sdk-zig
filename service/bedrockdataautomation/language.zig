const std = @import("std");

/// Supported input languages
pub const Language = enum {
    en,
    de,
    es,
    fr,
    it,
    pt,
    ja,
    ko,
    cn,
    tw,
    hk,

    pub const json_field_names = .{
        .en = "EN",
        .de = "DE",
        .es = "ES",
        .fr = "FR",
        .it = "IT",
        .pt = "PT",
        .ja = "JA",
        .ko = "KO",
        .cn = "CN",
        .tw = "TW",
        .hk = "HK",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .en => "EN",
            .de => "DE",
            .es => "ES",
            .fr => "FR",
            .it => "IT",
            .pt => "PT",
            .ja => "JA",
            .ko => "KO",
            .cn => "CN",
            .tw => "TW",
            .hk => "HK",
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
