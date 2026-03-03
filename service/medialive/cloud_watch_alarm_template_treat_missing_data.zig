const std = @import("std");

/// Specifies how missing data points are treated when evaluating the alarm's
/// condition.
pub const CloudWatchAlarmTemplateTreatMissingData = enum {
    not_breaching,
    breaching,
    ignore,
    missing,

    pub const json_field_names = .{
        .not_breaching = "notBreaching",
        .breaching = "breaching",
        .ignore = "ignore",
        .missing = "missing",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .not_breaching => "notBreaching",
            .breaching => "breaching",
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
