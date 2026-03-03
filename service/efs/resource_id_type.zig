const std = @import("std");

/// A preference indicating a choice to use 63bit/32bit IDs for all applicable
/// resources.
pub const ResourceIdType = enum {
    long_id,
    short_id,

    pub const json_field_names = .{
        .long_id = "LONG_ID",
        .short_id = "SHORT_ID",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .long_id => "LONG_ID",
            .short_id => "SHORT_ID",
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
