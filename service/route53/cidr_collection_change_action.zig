const std = @import("std");

pub const CidrCollectionChangeAction = enum {
    put,
    delete_if_exists,

    pub const json_field_names = .{
        .put = "PUT",
        .delete_if_exists = "DELETE_IF_EXISTS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .put => "PUT",
            .delete_if_exists => "DELETE_IF_EXISTS",
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
