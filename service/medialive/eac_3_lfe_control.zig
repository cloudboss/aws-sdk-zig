const std = @import("std");

/// Eac3 Lfe Control
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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
