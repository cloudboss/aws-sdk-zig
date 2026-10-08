const std = @import("std");

/// Strategy for handling resources created during a pentest.
pub const CleanUpStrategy = enum {
    /// Attempt to delete resources created during the pentest on a best-effort
    /// basis.
    best_effort_delete,
    /// Retain all resources created during the pentest.
    retain_all,

    pub const json_field_names = .{
        .best_effort_delete = "BEST_EFFORT_DELETE",
        .retain_all = "RETAIN_ALL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .best_effort_delete => "BEST_EFFORT_DELETE",
            .retain_all => "RETAIN_ALL",
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
