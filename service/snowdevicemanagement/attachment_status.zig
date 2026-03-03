const std = @import("std");

pub const AttachmentStatus = enum {
    attaching,
    attached,
    detaching,
    detached,

    pub const json_field_names = .{
        .attaching = "ATTACHING",
        .attached = "ATTACHED",
        .detaching = "DETACHING",
        .detached = "DETACHED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .attaching => "ATTACHING",
            .attached => "ATTACHED",
            .detaching => "DETACHING",
            .detached => "DETACHED",
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
