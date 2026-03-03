const std = @import("std");

pub const RuleExecutionType = enum {
    continuous,
    snapshots,
    continuous_and_snapshots,

    pub const json_field_names = .{
        .continuous = "CONTINUOUS",
        .snapshots = "SNAPSHOTS",
        .continuous_and_snapshots = "CONTINUOUS_AND_SNAPSHOTS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .continuous => "CONTINUOUS",
            .snapshots => "SNAPSHOTS",
            .continuous_and_snapshots => "CONTINUOUS_AND_SNAPSHOTS",
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
