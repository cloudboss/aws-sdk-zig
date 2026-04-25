const std = @import("std");

/// The type of an insight. Possible values are `EVENT` and
/// `RECOMMENDATION`.
pub const InsightType = enum {
    event,
    recommendation,

    pub const json_field_names = .{
        .event = "EVENT",
        .recommendation = "RECOMMENDATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .event => "EVENT",
            .recommendation => "RECOMMENDATION",
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
