const std = @import("std");

/// Recovery mode to use during launch. `FAST` skips conversion to reduce
/// recovery time. `OPTIMAL` runs full conversion for maximum compatibility.
pub const RecoveryMode = enum {
    fast,
    optimal,

    pub const json_field_names = .{
        .fast = "FAST",
        .optimal = "OPTIMAL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .fast => "FAST",
            .optimal => "OPTIMAL",
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
