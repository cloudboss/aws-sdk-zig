const std = @import("std");

/// Enumeration of condition matching requirements: MEETS_ALL requires all
/// conditions to match, MEETS_ANY requires at least one.
pub const FilterRequirement = enum {
    meets_all,
    meets_any,

    pub const json_field_names = .{
        .meets_all = "MEETS_ALL",
        .meets_any = "MEETS_ANY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .meets_all => "MEETS_ALL",
            .meets_any => "MEETS_ANY",
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
