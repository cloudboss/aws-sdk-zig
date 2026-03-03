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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
