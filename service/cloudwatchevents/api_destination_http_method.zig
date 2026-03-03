const std = @import("std");

pub const ApiDestinationHttpMethod = enum {
    post,
    get,
    head,
    options,
    put,
    patch,
    delete,

    pub const json_field_names = .{
        .post = "POST",
        .get = "GET",
        .head = "HEAD",
        .options = "OPTIONS",
        .put = "PUT",
        .patch = "PATCH",
        .delete = "DELETE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .post => "POST",
            .get => "GET",
            .head => "HEAD",
            .options => "OPTIONS",
            .put => "PUT",
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
