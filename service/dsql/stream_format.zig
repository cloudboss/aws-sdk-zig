const std = @import("std");

/// Stream record format.
///
/// **JSON**
///
/// Stream records are formatted as JSON.
pub const StreamFormat = enum {
    json,

    pub const json_field_names = .{
        .json = "JSON",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .json => "JSON",
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
