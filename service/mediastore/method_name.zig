const std = @import("std");

pub const MethodName = enum {
    put,
    get,
    delete,
    head,

    pub const json_field_names = .{
        .put = "PUT",
        .get = "GET",
        .delete = "DELETE",
        .head = "HEAD",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .put => "PUT",
            .get => "GET",
            .delete => "DELETE",
            .head => "HEAD",
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
