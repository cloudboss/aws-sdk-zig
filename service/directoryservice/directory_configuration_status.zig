const std = @import("std");

pub const DirectoryConfigurationStatus = enum {
    requested,
    updating,
    updated,
    failed,
    default,

    pub const json_field_names = .{
        .requested = "Requested",
        .updating = "Updating",
        .updated = "Updated",
        .failed = "Failed",
        .default = "Default",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .requested => "Requested",
            .updating => "Updating",
            .updated => "Updated",
            .failed => "Failed",
            .default => "Default",
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
