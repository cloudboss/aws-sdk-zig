const std = @import("std");

/// When encoding 3/2 audio, controls whether the LFE channel is enabled
pub const Eac3LfeControl = enum {
    lfe,
    no_lfe,

    pub const json_field_names = .{
        .lfe = "LFE",
        .no_lfe = "NO_LFE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .lfe => "LFE",
            .no_lfe => "NO_LFE",
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
