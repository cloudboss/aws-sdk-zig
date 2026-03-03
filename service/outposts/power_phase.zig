const std = @import("std");

pub const PowerPhase = enum {
    single_phase,
    three_phase,

    pub const json_field_names = .{
        .single_phase = "SINGLE_PHASE",
        .three_phase = "THREE_PHASE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .single_phase => "SINGLE_PHASE",
            .three_phase => "THREE_PHASE",
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
