const std = @import("std");

pub const DataProtectionStatus = enum {
    activated,
    deleted,
    archived,
    disabled,

    pub const json_field_names = .{
        .activated = "ACTIVATED",
        .deleted = "DELETED",
        .archived = "ARCHIVED",
        .disabled = "DISABLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .activated => "ACTIVATED",
            .deleted => "DELETED",
            .archived => "ARCHIVED",
            .disabled => "DISABLED",
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
