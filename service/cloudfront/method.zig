const std = @import("std");

pub const Method = enum {
    get,
    head,
    post,
    put,
    patch,
    options,
    delete,

    pub const json_field_names = .{
        .get = "GET",
        .head = "HEAD",
        .post = "POST",
        .put = "PUT",
        .patch = "PATCH",
        .options = "OPTIONS",
        .delete = "DELETE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .get => "GET",
            .head => "HEAD",
            .post => "POST",
            .put => "PUT",
            .patch => "PATCH",
            .options => "OPTIONS",
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
