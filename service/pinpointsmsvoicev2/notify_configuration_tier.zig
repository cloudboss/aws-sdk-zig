const std = @import("std");

/// The tier of a notify configuration.
///
/// * `BASIC` - Basic tier.
/// * `ADVANCED` - Advanced tier.
pub const NotifyConfigurationTier = enum {
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
