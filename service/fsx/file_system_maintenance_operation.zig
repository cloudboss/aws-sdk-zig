const std = @import("std");

/// An enumeration specifying the currently ongoing maintenance operation.
pub const FileSystemMaintenanceOperation = enum {
    patching,
    backing_up,

    pub const json_field_names = .{
        .patching = "PATCHING",
        .backing_up = "BACKING_UP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .patching => "PATCHING",
            .backing_up => "BACKING_UP",
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
