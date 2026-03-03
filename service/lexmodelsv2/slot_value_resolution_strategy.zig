const std = @import("std");

pub const SlotValueResolutionStrategy = enum {
    original_value,
    top_resolution,
    concatenation,

    pub const json_field_names = .{
        .original_value = "OriginalValue",
        .top_resolution = "TopResolution",
        .concatenation = "Concatenation",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .original_value => "OriginalValue",
            .top_resolution => "TopResolution",
            .concatenation => "Concatenation",
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
