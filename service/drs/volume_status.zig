const std = @import("std");

pub const VolumeStatus = enum {
    regular,
    contains_marketplace_product_codes,
    missing_volume_attributes,
    missing_volume_attributes_and_precheck_unavailable,
    pending,

    pub const json_field_names = .{
        .regular = "REGULAR",
        .contains_marketplace_product_codes = "CONTAINS_MARKETPLACE_PRODUCT_CODES",
        .missing_volume_attributes = "MISSING_VOLUME_ATTRIBUTES",
        .missing_volume_attributes_and_precheck_unavailable = "MISSING_VOLUME_ATTRIBUTES_AND_PRECHECK_UNAVAILABLE",
        .pending = "PENDING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .regular => "REGULAR",
            .contains_marketplace_product_codes => "CONTAINS_MARKETPLACE_PRODUCT_CODES",
            .missing_volume_attributes => "MISSING_VOLUME_ATTRIBUTES",
            .missing_volume_attributes_and_precheck_unavailable => "MISSING_VOLUME_ATTRIBUTES_AND_PRECHECK_UNAVAILABLE",
            .pending => "PENDING",
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
