const std = @import("std");

/// A standard input has two sources and a single pipeline input only has one.
pub const InputClass = enum {
    standard,
    single_pipeline,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .single_pipeline = "SINGLE_PIPELINE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .standard => "STANDARD",
            .single_pipeline => "SINGLE_PIPELINE",
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
