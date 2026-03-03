const std = @import("std");

pub const EntryType = enum {
    fms_managed_first_entry,
    fms_managed_last_entry,
    custom_entry,

    pub const json_field_names = .{
        .fms_managed_first_entry = "FMS_MANAGED_FIRST_ENTRY",
        .fms_managed_last_entry = "FMS_MANAGED_LAST_ENTRY",
        .custom_entry = "CUSTOM_ENTRY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .fms_managed_first_entry => "FMS_MANAGED_FIRST_ENTRY",
            .fms_managed_last_entry => "FMS_MANAGED_LAST_ENTRY",
            .custom_entry => "CUSTOM_ENTRY",
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
