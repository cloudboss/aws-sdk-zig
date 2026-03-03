const std = @import("std");

pub const DatasetType = enum {
    target_time_series,
    related_time_series,
    item_metadata,

    pub const json_field_names = .{
        .target_time_series = "TARGET_TIME_SERIES",
        .related_time_series = "RELATED_TIME_SERIES",
        .item_metadata = "ITEM_METADATA",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .target_time_series => "TARGET_TIME_SERIES",
            .related_time_series => "RELATED_TIME_SERIES",
            .item_metadata => "ITEM_METADATA",
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
