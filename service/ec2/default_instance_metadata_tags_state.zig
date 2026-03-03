const std = @import("std");

pub const DefaultInstanceMetadataTagsState = enum {
    disabled,
    enabled,
    no_preference,

    pub const json_field_names = .{
        .disabled = "disabled",
        .enabled = "enabled",
        .no_preference = "no-preference",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .disabled => "disabled",
            .enabled => "enabled",
            .no_preference => "no-preference",
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
