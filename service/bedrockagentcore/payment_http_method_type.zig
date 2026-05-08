const std = @import("std");

pub const PaymentHttpMethodType = enum {
    get,
    post,
    put,
    delete,
    patch,

    pub const json_field_names = .{
        .get = "GET",
        .post = "POST",
        .put = "PUT",
        .delete = "DELETE",
        .patch = "PATCH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .get => "GET",
            .post => "POST",
            .put => "PUT",
            .delete => "DELETE",
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
