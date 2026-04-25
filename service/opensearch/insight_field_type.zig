const std = @import("std");

/// The type of an insight field. Possible values are `text` and
/// `metric`.
pub const InsightFieldType = enum {
    text,
    metric,

    pub const json_field_names = .{
        .text = "text",
        .metric = "metric",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .text => "text",
            .metric => "metric",
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
