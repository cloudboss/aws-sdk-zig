const std = @import("std");

/// The type of browser enterprise policy. Available values are `MANAGED` and
/// `RECOMMENDED`.
pub const BrowserEnterprisePolicyType = enum {
    managed,
    recommended,

    pub const json_field_names = .{
        .managed = "MANAGED",
        .recommended = "RECOMMENDED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .managed => "MANAGED",
            .recommended => "RECOMMENDED",
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
