const std = @import("std");

pub const DomainStatus = enum {
    active,
    creation_in_progress,
    creation_failed,

    pub const json_field_names = .{
        .active = "Active",
        .creation_in_progress = "CreationInProgress",
        .creation_failed = "CreationFailed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "Active",
            .creation_in_progress => "CreationInProgress",
            .creation_failed => "CreationFailed",
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
