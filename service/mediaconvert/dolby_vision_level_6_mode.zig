const std = @import("std");

/// Use Dolby Vision Mode to choose how the service will handle Dolby Vision
/// MaxCLL and MaxFALL properies.
pub const DolbyVisionLevel6Mode = enum {
    passthrough,
    recalculate,
    specify,

    pub const json_field_names = .{
        .passthrough = "PASSTHROUGH",
        .recalculate = "RECALCULATE",
        .specify = "SPECIFY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .passthrough => "PASSTHROUGH",
            .recalculate => "RECALCULATE",
            .specify => "SPECIFY",
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
