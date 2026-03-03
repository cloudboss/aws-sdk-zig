const std = @import("std");

pub const OverwriteOption = enum {
    create_new_report,
    overwrite_report,

    pub const json_field_names = .{
        .create_new_report = "CREATE_NEW_REPORT",
        .overwrite_report = "OVERWRITE_REPORT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .create_new_report => "CREATE_NEW_REPORT",
            .overwrite_report => "OVERWRITE_REPORT",
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
