const std = @import("std");

pub const ArchiveState = enum {
    active,
    pending_deletion,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .pending_deletion = "PENDING_DELETION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .active => "ACTIVE",
            .pending_deletion => "PENDING_DELETION",
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
