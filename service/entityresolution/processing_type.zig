const std = @import("std");

pub const ProcessingType = enum {
    consistent,
    eventual,
    eventual_no_lookup,

    pub const json_field_names = .{
        .consistent = "CONSISTENT",
        .eventual = "EVENTUAL",
        .eventual_no_lookup = "EVENTUAL_NO_LOOKUP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .consistent => "CONSISTENT",
            .eventual => "EVENTUAL",
            .eventual_no_lookup => "EVENTUAL_NO_LOOKUP",
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
