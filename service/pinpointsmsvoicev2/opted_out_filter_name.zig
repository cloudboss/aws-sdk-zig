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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
