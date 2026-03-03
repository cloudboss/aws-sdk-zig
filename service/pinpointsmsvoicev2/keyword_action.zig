const std = @import("std");

pub const KeywordAction = enum {
    automatic_response,
    opt_out,
    opt_in,

    pub const json_field_names = .{
        .automatic_response = "AUTOMATIC_RESPONSE",
        .opt_out = "OPT_OUT",
        .opt_in = "OPT_IN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .automatic_response => "AUTOMATIC_RESPONSE",
            .opt_out => "OPT_OUT",
            .opt_in => "OPT_IN",
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
