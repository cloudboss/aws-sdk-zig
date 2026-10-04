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
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
