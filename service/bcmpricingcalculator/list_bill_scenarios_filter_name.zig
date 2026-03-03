const std = @import("std");

pub const ListBillScenariosFilterName = enum {
    status,
    name,
    group_sharing_preference,
    cost_category_arn,

    pub const json_field_names = .{
        .status = "STATUS",
        .name = "NAME",
        .group_sharing_preference = "GROUP_SHARING_PREFERENCE",
        .cost_category_arn = "COST_CATEGORY_ARN",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .status => "STATUS",
            .name => "NAME",
            .group_sharing_preference => "GROUP_SHARING_PREFERENCE",
            .cost_category_arn => "COST_CATEGORY_ARN",
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
