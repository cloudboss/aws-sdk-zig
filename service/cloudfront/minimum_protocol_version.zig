const std = @import("std");

pub const MinimumProtocolVersion = enum {
    ss_lv_3,
    tl_sv_1,
    tl_sv_1_2016,
    tl_sv_1_1_2016,
    tl_sv_1_2_2018,
    tl_sv_1_2_2019,
    tl_sv_1_2_2021,
    tl_sv_1_3_2025,
    tl_sv_1_2_2025,

    pub const json_field_names = .{
        .ss_lv_3 = "SSLv3",
        .tl_sv_1 = "TLSv1",
        .tl_sv_1_2016 = "TLSv1_2016",
        .tl_sv_1_1_2016 = "TLSv1.1_2016",
        .tl_sv_1_2_2018 = "TLSv1.2_2018",
        .tl_sv_1_2_2019 = "TLSv1.2_2019",
        .tl_sv_1_2_2021 = "TLSv1.2_2021",
        .tl_sv_1_3_2025 = "TLSv1.3_2025",
        .tl_sv_1_2_2025 = "TLSv1.2_2025",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ss_lv_3 => "SSLv3",
            .tl_sv_1 => "TLSv1",
            .tl_sv_1_2016 => "TLSv1_2016",
            .tl_sv_1_1_2016 => "TLSv1.1_2016",
            .tl_sv_1_2_2018 => "TLSv1.2_2018",
            .tl_sv_1_2_2019 => "TLSv1.2_2019",
            .tl_sv_1_2_2021 => "TLSv1.2_2021",
            .tl_sv_1_3_2025 => "TLSv1.3_2025",
            .tl_sv_1_2_2025 => "TLSv1.2_2025",
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
