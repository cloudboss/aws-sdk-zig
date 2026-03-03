const std = @import("std");

/// The rule schema version in this particular cost category.
pub const CostCategoryRuleVersion = enum {
    cost_category_expression_v1,

    pub const json_field_names = .{
        .cost_category_expression_v1 = "CostCategoryExpression.v1",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cost_category_expression_v1 => "CostCategoryExpression.v1",
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
