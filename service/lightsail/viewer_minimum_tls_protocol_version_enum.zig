const std = @import("std");

pub const ViewerMinimumTlsProtocolVersionEnum = enum {
    tl_sv_11_2016,
    tl_sv_12_2018,
    tl_sv_12_2019,
    tl_sv_12_2021,

    pub const json_field_names = .{
        .tl_sv_11_2016 = "TLSv1.1_2016",
        .tl_sv_12_2018 = "TLSv1.2_2018",
        .tl_sv_12_2019 = "TLSv1.2_2019",
        .tl_sv_12_2021 = "TLSv1.2_2021",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .tl_sv_11_2016 => "TLSv1.1_2016",
            .tl_sv_12_2018 => "TLSv1.2_2018",
            .tl_sv_12_2019 => "TLSv1.2_2019",
            .tl_sv_12_2021 => "TLSv1.2_2021",
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
