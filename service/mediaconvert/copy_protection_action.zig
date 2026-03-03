const std = @import("std");

/// The action to take on copy and redistribution control XDS packets. If you
/// select PASSTHROUGH, packets will not be changed. If you select STRIP, any
/// packets will be removed in output captions.
pub const CopyProtectionAction = enum {
    passthrough,
    strip,

    pub const json_field_names = .{
        .passthrough = "PASSTHROUGH",
        .strip = "STRIP",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .passthrough => "PASSTHROUGH",
            .strip => "STRIP",
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
