const std = @import("std");

pub const RestApiMethod = enum {
    get,
    delete,
    head,
    options,
    patch,
    put,
    post,

    pub const json_field_names = .{
        .get = "GET",
        .delete = "DELETE",
        .head = "HEAD",
        .options = "OPTIONS",
        .patch = "PATCH",
        .put = "PUT",
        .post = "POST",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .get => "GET",
            .delete => "DELETE",
            .head => "HEAD",
            .options => "OPTIONS",
            .patch => "PATCH",
            .put => "PUT",
            .post => "POST",
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
