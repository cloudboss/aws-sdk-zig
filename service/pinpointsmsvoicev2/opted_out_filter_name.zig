const std = @import("std");

pub const OptedOutFilterName = enum {
    end_user_opted_out,

    pub const json_field_names = .{
        .end_user_opted_out = "end-user-opted-out",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .end_user_opted_out => "end-user-opted-out",
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
