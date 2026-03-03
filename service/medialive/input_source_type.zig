const std = @import("std");

/// There are two types of input sources, static and dynamic. If an input source
/// is dynamic you can
/// change the source url of the input dynamically using an input switch action.
/// Currently, two input types
/// support a dynamic url at this time, MP4_FILE and TS_FILE. By default all
/// input sources are static.
pub const InputSourceType = enum {
    static,
    dynamic,

    pub const json_field_names = .{
        .static = "STATIC",
        .dynamic = "DYNAMIC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .static => "STATIC",
            .dynamic => "DYNAMIC",
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
