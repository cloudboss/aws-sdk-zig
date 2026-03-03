const std = @import("std");

pub const HttpMethod = enum {
    get,
    head,
    post,
    put,
    delete,
    connect,
    options,
    trace,
    patch,

    pub const json_field_names = .{
        .get = "GET",
        .head = "HEAD",
        .post = "POST",
        .put = "PUT",
        .delete = "DELETE",
        .connect = "CONNECT",
        .options = "OPTIONS",
        .trace = "TRACE",
        .patch = "PATCH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .get => "GET",
            .head => "HEAD",
            .post => "POST",
            .put => "PUT",
            .delete => "DELETE",
            .connect => "CONNECT",
            .options => "OPTIONS",
            .trace => "TRACE",
            .patch => "PATCH",
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
