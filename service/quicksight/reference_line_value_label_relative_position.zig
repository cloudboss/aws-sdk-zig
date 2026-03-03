const std = @import("std");

pub const ReferenceLineValueLabelRelativePosition = enum {
    before_custom_label,
    after_custom_label,

    pub const json_field_names = .{
        .before_custom_label = "BEFORE_CUSTOM_LABEL",
        .after_custom_label = "AFTER_CUSTOM_LABEL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .before_custom_label => "BEFORE_CUSTOM_LABEL",
            .after_custom_label => "AFTER_CUSTOM_LABEL",
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
