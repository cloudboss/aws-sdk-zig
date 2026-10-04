const std = @import("std");

/// Stream ordering mode.
///
/// **UNORDERED**
///
/// Changes are streamed without ordering guarantees.
pub const StreamOrdering = enum {
    unordered,

    pub const json_field_names = .{
        .unordered = "UNORDERED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .unordered => "UNORDERED",
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
