const std = @import("std");

/// Ebu Tt DDestination Style Control
pub const EbuTtDDestinationStyleControl = enum {
    exclude,
    include,

    pub const json_field_names = .{
        .exclude = "EXCLUDE",
        .include = "INCLUDE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .exclude => "EXCLUDE",
            .include => "INCLUDE",
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
