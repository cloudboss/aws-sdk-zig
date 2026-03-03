const std = @import("std");

pub const HttpMethod = enum {
    delete,
    get,
    head,
    options,
    patch,
    post,
    put,

    pub const json_field_names = .{
        .delete = "DELETE",
        .get = "GET",
        .head = "HEAD",
        .options = "OPTIONS",
        .patch = "PATCH",
        .post = "POST",
        .put = "PUT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .delete => "DELETE",
            .get => "GET",
            .head => "HEAD",
            .options => "OPTIONS",
            .patch => "PATCH",
            .post => "POST",
            .put => "PUT",
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
