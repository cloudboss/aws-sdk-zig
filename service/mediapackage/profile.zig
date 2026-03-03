const std = @import("std");

pub const Profile = enum {
    none,
    hbbtv_1_5,
    hybridcast,
    dvb_dash_2014,

    pub const json_field_names = .{
        .none = "NONE",
        .hbbtv_1_5 = "HBBTV_1_5",
        .hybridcast = "HYBRIDCAST",
        .dvb_dash_2014 = "DVB_DASH_2014",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .hbbtv_1_5 => "HBBTV_1_5",
            .hybridcast => "HYBRIDCAST",
            .dvb_dash_2014 => "DVB_DASH_2014",
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
