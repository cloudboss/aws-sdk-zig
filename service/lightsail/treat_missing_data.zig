const std = @import("std");

pub const TreatMissingData = enum {
    breaching,
    not_breaching,
    ignore,
    missing,

    pub const json_field_names = .{
        .breaching = "breaching",
        .not_breaching = "notBreaching",
        .ignore = "ignore",
        .missing = "missing",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .breaching => "breaching",
            .not_breaching => "notBreaching",
            .ignore => "ignore",
            .missing => "missing",
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
