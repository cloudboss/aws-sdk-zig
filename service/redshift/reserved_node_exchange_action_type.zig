const std = @import("std");

pub const ReservedNodeExchangeActionType = enum {
    restore_cluster,
    resize_cluster,

    pub const json_field_names = .{
        .restore_cluster = "restore-cluster",
        .resize_cluster = "resize-cluster",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .restore_cluster => "restore-cluster",
            .resize_cluster => "resize-cluster",
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
