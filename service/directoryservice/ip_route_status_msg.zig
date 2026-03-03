const std = @import("std");

pub const IpRouteStatusMsg = enum {
    adding,
    added,
    removing,
    removed,
    add_failed,
    remove_failed,

    pub const json_field_names = .{
        .adding = "Adding",
        .added = "Added",
        .removing = "Removing",
        .removed = "Removed",
        .add_failed = "AddFailed",
        .remove_failed = "RemoveFailed",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .adding => "Adding",
            .added => "Added",
            .removing => "Removing",
            .removed => "Removed",
            .add_failed => "AddFailed",
            .remove_failed => "RemoveFailed",
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
