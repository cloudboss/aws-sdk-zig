const std = @import("std");

pub const AmiProductSortBy = enum {
    entity_id,
    last_modified_date,
    product_title,
    visibility,

    pub const json_field_names = .{
        .entity_id = "EntityId",
        .last_modified_date = "LastModifiedDate",
        .product_title = "ProductTitle",
        .visibility = "Visibility",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .entity_id => "EntityId",
            .last_modified_date => "LastModifiedDate",
            .product_title => "ProductTitle",
            .visibility => "Visibility",
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
