const std = @import("std");

pub const PatchProperty = enum {
    product,
    patch_product_family,
    patch_classification,
    patch_msrc_severity,
    patch_priority,
    patch_severity,

    pub const json_field_names = .{
        .product = "PRODUCT",
        .patch_product_family = "PRODUCT_FAMILY",
        .patch_classification = "CLASSIFICATION",
        .patch_msrc_severity = "MSRC_SEVERITY",
        .patch_priority = "PRIORITY",
        .patch_severity = "SEVERITY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .product => "PRODUCT",
            .patch_product_family => "PRODUCT_FAMILY",
            .patch_classification => "CLASSIFICATION",
            .patch_msrc_severity => "MSRC_SEVERITY",
            .patch_priority => "PRIORITY",
            .patch_severity => "SEVERITY",
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
