const std = @import("std");

pub const ContainerMode = enum {
    single_model,
    multi_model,

    pub const json_field_names = .{
        .single_model = "SingleModel",
        .multi_model = "MultiModel",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .single_model => "SingleModel",
            .multi_model => "MultiModel",
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
