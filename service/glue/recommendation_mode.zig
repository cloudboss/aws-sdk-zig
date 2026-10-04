const std = @import("std");

/// Specifies the mode for how Glue Data Quality recommends rules.
///
/// * `BASIC` uses an Glue job to analyze table data and recommend rules. This
///   value is the default.
///
/// * `ADVANCED` uses Amazon Athena to analyze table data and Amazon Bedrock to
///   recommend rules.
pub const RecommendationMode = enum {
    basic,
    advanced,

    pub const json_field_names = .{
        .basic = "BASIC",
        .advanced = "ADVANCED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .basic => "BASIC",
            .advanced => "ADVANCED",
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
