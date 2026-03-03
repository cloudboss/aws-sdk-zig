const std = @import("std");

pub const BuildType = enum {
    user_initiated,
    scheduled,
    import,
    import_iso,

    pub const json_field_names = .{
        .user_initiated = "USER_INITIATED",
        .scheduled = "SCHEDULED",
        .import = "IMPORT",
        .import_iso = "IMPORT_ISO",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .user_initiated => "USER_INITIATED",
            .scheduled => "SCHEDULED",
            .import => "IMPORT",
            .import_iso => "IMPORT_ISO",
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
