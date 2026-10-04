const std = @import("std");

/// Instance limits handling
pub const InstanceLimitsHandling = enum {
    opt_in,
    opt_out,

    pub const json_field_names = .{
        .opt_in = "OPT_IN",
        .opt_out = "OPT_OUT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .opt_in => "OPT_IN",
            .opt_out => "OPT_OUT",
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
