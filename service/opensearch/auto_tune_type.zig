const std = @import("std");

/// Specifies the Auto-Tune type. Valid value is SCHEDULED_ACTION.
pub const AutoTuneType = enum {
    scheduled_action,

    pub const json_field_names = .{
        .scheduled_action = "SCHEDULED_ACTION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .scheduled_action => "SCHEDULED_ACTION",
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
