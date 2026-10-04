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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
