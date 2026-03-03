const std = @import("std");

pub const RehydrationType = enum {
    entire_past_session,
    from_segment,

    pub const json_field_names = .{
        .entire_past_session = "ENTIRE_PAST_SESSION",
        .from_segment = "FROM_SEGMENT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .entire_past_session => "ENTIRE_PAST_SESSION",
            .from_segment => "FROM_SEGMENT",
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
