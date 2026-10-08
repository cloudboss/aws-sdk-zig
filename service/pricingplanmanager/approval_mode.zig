const std = @import("std");

/// Determines whether a subscription requires explicit approval before billing
/// starts.
pub const ApprovalMode = enum {
    manual,
    immediate,

    pub const json_field_names = .{
        .manual = "MANUAL",
        .immediate = "IMMEDIATE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .manual => "MANUAL",
            .immediate => "IMMEDIATE",
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
