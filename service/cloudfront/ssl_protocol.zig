const std = @import("std");

pub const SslProtocol = enum {
    ss_lv_3,
    tl_sv_1,
    tl_sv_1_1,
    tl_sv_1_2,

    pub const json_field_names = .{
        .ss_lv_3 = "SSLv3",
        .tl_sv_1 = "TLSv1",
        .tl_sv_1_1 = "TLSv1.1",
        .tl_sv_1_2 = "TLSv1.2",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ss_lv_3 => "SSLv3",
            .tl_sv_1 => "TLSv1",
            .tl_sv_1_1 => "TLSv1.1",
            .tl_sv_1_2 => "TLSv1.2",
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
