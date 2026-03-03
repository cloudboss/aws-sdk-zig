const std = @import("std");

pub const ICD10CMEntityType = enum {
    dx_name,
    time_expression,

    pub const json_field_names = .{
        .dx_name = "DX_NAME",
        .time_expression = "TIME_EXPRESSION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .dx_name => "DX_NAME",
            .time_expression => "TIME_EXPRESSION",
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
