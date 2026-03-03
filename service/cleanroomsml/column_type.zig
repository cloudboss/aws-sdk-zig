const std = @import("std");

pub const ColumnType = enum {
    user_id,
    item_id,
    timestamp,
    categorical_feature,
    numerical_feature,

    pub const json_field_names = .{
        .user_id = "USER_ID",
        .item_id = "ITEM_ID",
        .timestamp = "TIMESTAMP",
        .categorical_feature = "CATEGORICAL_FEATURE",
        .numerical_feature = "NUMERICAL_FEATURE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .user_id => "USER_ID",
            .item_id => "ITEM_ID",
            .timestamp => "TIMESTAMP",
            .categorical_feature => "CATEGORICAL_FEATURE",
            .numerical_feature => "NUMERICAL_FEATURE",
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
