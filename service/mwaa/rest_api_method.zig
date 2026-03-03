const std = @import("std");

pub const RestApiMethod = enum {
    get,
    put,
    post,
    patch,
    delete,

    pub const json_field_names = .{
        .get = "GET",
        .put = "PUT",
        .post = "POST",
        .patch = "PATCH",
        .delete = "DELETE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .get => "GET",
            .put => "PUT",
            .post => "POST",
            .patch => "PATCH",
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
