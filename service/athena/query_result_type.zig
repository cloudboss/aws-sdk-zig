const std = @import("std");

pub const QueryResultType = enum {
    data_manifest,
    data_rows,

    pub const json_field_names = .{
        .data_manifest = "DATA_MANIFEST",
        .data_rows = "DATA_ROWS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .data_manifest => "DATA_MANIFEST",
            .data_rows => "DATA_ROWS",
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
