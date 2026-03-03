const std = @import("std");

pub const Tcs = enum {
    sdr,
    pq,
    hlg,
    linear,
    bt2100_linpq,
    bt2100_linhlg,
    st2065_1,
    st428_1,
    density,

    pub const json_field_names = .{
        .sdr = "SDR",
        .pq = "PQ",
        .hlg = "HLG",
        .linear = "LINEAR",
        .bt2100_linpq = "BT2100LINPQ",
        .bt2100_linhlg = "BT2100LINHLG",
        .st2065_1 = "ST2065-1",
        .st428_1 = "ST428-1",
        .density = "DENSITY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .sdr => "SDR",
            .pq => "PQ",
            .hlg => "HLG",
            .linear => "LINEAR",
            .bt2100_linpq => "BT2100LINPQ",
            .bt2100_linhlg => "BT2100LINHLG",
            .st2065_1 => "ST2065-1",
            .st428_1 => "ST428-1",
            .density => "DENSITY",
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
