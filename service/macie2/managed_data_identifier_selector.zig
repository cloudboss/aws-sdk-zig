const std = @import("std");

/// The selection type that determines which managed data identifiers a
/// classification job uses to analyze data. Valid values are:
pub const ManagedDataIdentifierSelector = enum {
    all,
    exclude,
    include,
    none,
    recommended,

    pub const json_field_names = .{
        .all = "ALL",
        .exclude = "EXCLUDE",
        .include = "INCLUDE",
        .none = "NONE",
        .recommended = "RECOMMENDED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .all => "ALL",
            .exclude => "EXCLUDE",
            .include => "INCLUDE",
            .none => "NONE",
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
