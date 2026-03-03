const std = @import("std");

/// Whether or not Amazon Web Services includes resource IDs in the report.
pub const SchemaElement = enum {
    resources,
    split_cost_allocation_data,
    manual_discount_compatibility,

    pub const json_field_names = .{
        .resources = "RESOURCES",
        .split_cost_allocation_data = "SPLIT_COST_ALLOCATION_DATA",
        .manual_discount_compatibility = "MANUAL_DISCOUNT_COMPATIBILITY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .resources => "RESOURCES",
            .split_cost_allocation_data => "SPLIT_COST_ALLOCATION_DATA",
            .manual_discount_compatibility => "MANUAL_DISCOUNT_COMPATIBILITY",
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
