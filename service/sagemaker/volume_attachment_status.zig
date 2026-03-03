const std = @import("std");

pub const VolumeAttachmentStatus = enum {
    attaching,
    attached,
    detaching,
    detached,
    busy,

    pub const json_field_names = .{
        .attaching = "attaching",
        .attached = "attached",
        .detaching = "detaching",
        .detached = "detached",
        .busy = "busy",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .attaching => "attaching",
            .attached => "attached",
            .detaching => "detaching",
            .detached => "detached",
            .busy => "busy",
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
