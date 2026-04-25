const std = @import("std");

pub const ModelInvocationType = enum {
    invoke_model,
    converse,

    pub const json_field_names = .{
        .invoke_model = "InvokeModel",
        .converse = "Converse",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invoke_model => "InvokeModel",
            .converse => "Converse",
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
