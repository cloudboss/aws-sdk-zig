const std = @import("std");

pub const WorkflowStepType = enum {
    copy,
    custom,
    tag,
    delete,
    decrypt,

    pub const json_field_names = .{
        .copy = "COPY",
        .custom = "CUSTOM",
        .tag = "TAG",
        .delete = "DELETE",
        .decrypt = "DECRYPT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .copy => "COPY",
            .custom => "CUSTOM",
            .tag => "TAG",
            .delete => "DELETE",
            .decrypt => "DECRYPT",
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
