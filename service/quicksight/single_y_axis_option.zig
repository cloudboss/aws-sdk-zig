const std = @import("std");

pub const SingleYAxisOption = enum {
    primary_y_axis,

    pub const json_field_names = .{
        .primary_y_axis = "PRIMARY_Y_AXIS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .primary_y_axis => "PRIMARY_Y_AXIS",
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
