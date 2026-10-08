const std = @import("std");

pub const PurchaseOptionFilterType = enum {
    product_id,
    seller_of_record_profile_id,
    purchase_option_type,
    visibility_scope,
    availability_status,

    pub const json_field_names = .{
        .product_id = "PRODUCT_ID",
        .seller_of_record_profile_id = "SELLER_OF_RECORD_PROFILE_ID",
        .purchase_option_type = "PURCHASE_OPTION_TYPE",
        .visibility_scope = "VISIBILITY_SCOPE",
        .availability_status = "AVAILABILITY_STATUS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .product_id => "PRODUCT_ID",
            .seller_of_record_profile_id => "SELLER_OF_RECORD_PROFILE_ID",
            .purchase_option_type => "PURCHASE_OPTION_TYPE",
            .visibility_scope => "VISIBILITY_SCOPE",
            .availability_status => "AVAILABILITY_STATUS",
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
