const std = @import("std");

/// Optional. Ignore this setting unless Nagra support directs you to specify a
/// value. When you don't specify a value here, the Nagra NexGuard library uses
/// its default value.
pub const WatermarkingStrength = enum {
    lightest,
    lighter,
    default,
    stronger,
    strongest,

    pub const json_field_names = .{
        .lightest = "LIGHTEST",
        .lighter = "LIGHTER",
        .default = "DEFAULT",
        .stronger = "STRONGER",
        .strongest = "STRONGEST",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .lightest => "LIGHTEST",
            .lighter => "LIGHTER",
            .default => "DEFAULT",
            .stronger => "STRONGER",
            .strongest => "STRONGEST",
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
