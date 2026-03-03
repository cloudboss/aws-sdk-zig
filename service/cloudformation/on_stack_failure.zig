const std = @import("std");

pub const OnStackFailure = enum {
    do_nothing,
    rollback,
    delete,

    pub const json_field_names = .{
        .do_nothing = "DO_NOTHING",
        .rollback = "ROLLBACK",
        .delete = "DELETE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .do_nothing => "DO_NOTHING",
            .rollback => "ROLLBACK",
            .delete => "DELETE",
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
