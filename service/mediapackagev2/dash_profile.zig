const std = @import("std");

pub const DashProfile = enum {
    dvb_dash,

    pub const json_field_names = .{
        .dvb_dash = "DVB_DASH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .dvb_dash => "DVB_DASH",
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
