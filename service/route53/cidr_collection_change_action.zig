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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
