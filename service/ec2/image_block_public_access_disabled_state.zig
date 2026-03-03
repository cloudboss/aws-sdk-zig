const std = @import("std");

pub const ImageBlockPublicAccessDisabledState = enum {
    unblocked,

    pub const json_field_names = .{
        .unblocked = "unblocked",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .unblocked => "unblocked",
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
