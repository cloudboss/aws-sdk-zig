const std = @import("std");

/// The https policy to use for tracking open and click events. If the value is
/// OPTIONAL or HttpsPolicy is not
/// specified, the open trackers use HTTP and click tracker use the original
/// protocol of the link.
/// If the value is REQUIRE, both open and click tracker uses HTTPS and if the
/// value is REQUIRE_OPEN_ONLY
/// open tracker uses HTTPS and link tracker is same as original protocol of the
/// link.
pub const HttpsPolicy = enum {
    require,
    require_open_only,
    optional,

    pub const json_field_names = .{
        .require = "REQUIRE",
        .require_open_only = "REQUIRE_OPEN_ONLY",
        .optional = "OPTIONAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .require => "REQUIRE",
            .require_open_only => "REQUIRE_OPEN_ONLY",
            .optional => "OPTIONAL",
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
