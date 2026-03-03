const std = @import("std");

pub const FpgaImageAttributeName = enum {
    description,
    name,
    load_permission,
    product_codes,

    pub const json_field_names = .{
        .description = "description",
        .name = "name",
        .load_permission = "loadPermission",
        .product_codes = "productCodes",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .description => "description",
            .name => "name",
            .load_permission => "loadPermission",
            .product_codes => "productCodes",
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
