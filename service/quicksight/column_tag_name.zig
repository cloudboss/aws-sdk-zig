const std = @import("std");

pub const ColumnTagName = enum {
    column_geographic_role,
    column_description,

    pub const json_field_names = .{
        .column_geographic_role = "COLUMN_GEOGRAPHIC_ROLE",
        .column_description = "COLUMN_DESCRIPTION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .column_geographic_role => "COLUMN_GEOGRAPHIC_ROLE",
            .column_description => "COLUMN_DESCRIPTION",
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
