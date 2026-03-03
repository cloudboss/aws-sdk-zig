const std = @import("std");

pub const TransferOption = enum {
    import,
    @"export",
    local_use,

    pub const json_field_names = .{
        .import = "IMPORT",
        .@"export" = "EXPORT",
        .local_use = "LOCAL_USE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .import => "IMPORT",
            .@"export" => "EXPORT",
            .local_use => "LOCAL_USE",
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
