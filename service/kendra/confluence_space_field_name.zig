const std = @import("std");

pub const ConfluenceSpaceFieldName = enum {
    display_url,
    item_type,
    space_key,
    url,

    pub const json_field_names = .{
        .display_url = "DISPLAY_URL",
        .item_type = "ITEM_TYPE",
        .space_key = "SPACE_KEY",
        .url = "URL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .display_url => "DISPLAY_URL",
            .item_type => "ITEM_TYPE",
            .space_key => "SPACE_KEY",
            .url => "URL",
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
