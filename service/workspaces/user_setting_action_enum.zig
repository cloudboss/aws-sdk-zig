const std = @import("std");

pub const UserSettingActionEnum = enum {
    clipboard_copy_from_local_device,
    clipboard_copy_to_local_device,
    printing_to_local_device,
    smart_card,

    pub const json_field_names = .{
        .clipboard_copy_from_local_device = "CLIPBOARD_COPY_FROM_LOCAL_DEVICE",
        .clipboard_copy_to_local_device = "CLIPBOARD_COPY_TO_LOCAL_DEVICE",
        .printing_to_local_device = "PRINTING_TO_LOCAL_DEVICE",
        .smart_card = "SMART_CARD",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .clipboard_copy_from_local_device => "CLIPBOARD_COPY_FROM_LOCAL_DEVICE",
            .clipboard_copy_to_local_device => "CLIPBOARD_COPY_TO_LOCAL_DEVICE",
            .printing_to_local_device => "PRINTING_TO_LOCAL_DEVICE",
            .smart_card => "SMART_CARD",
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
