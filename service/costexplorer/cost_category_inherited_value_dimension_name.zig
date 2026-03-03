const std = @import("std");

pub const CostCategoryInheritedValueDimensionName = enum {
    linked_account_name,
    tag,

    pub const json_field_names = .{
        .linked_account_name = "LINKED_ACCOUNT_NAME",
        .tag = "TAG",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .linked_account_name => "LINKED_ACCOUNT_NAME",
            .tag => "TAG",
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
