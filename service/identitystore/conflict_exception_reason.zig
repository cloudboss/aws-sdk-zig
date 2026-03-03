const std = @import("std");

pub const ConflictExceptionReason = enum {
    uniqueness_constraint_violation,
    concurrent_modification,

    pub const json_field_names = .{
        .uniqueness_constraint_violation = "UNIQUENESS_CONSTRAINT_VIOLATION",
        .concurrent_modification = "CONCURRENT_MODIFICATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .uniqueness_constraint_violation => "UNIQUENESS_CONSTRAINT_VIOLATION",
            .concurrent_modification => "CONCURRENT_MODIFICATION",
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
