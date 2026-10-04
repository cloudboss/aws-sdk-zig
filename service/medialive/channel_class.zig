const std = @import("std");

/// A standard channel has two encoding pipelines and a single pipeline channel
/// only has one.
pub const ChannelClass = enum {
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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
