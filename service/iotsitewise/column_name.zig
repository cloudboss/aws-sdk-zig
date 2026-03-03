const std = @import("std");

pub const ColumnName = enum {
    alias,
    asset_id,
    property_id,
    data_type,
    timestamp_seconds,
    timestamp_nano_offset,
    quality,
    value,

    pub const json_field_names = .{
        .alias = "ALIAS",
        .asset_id = "ASSET_ID",
        .property_id = "PROPERTY_ID",
        .data_type = "DATA_TYPE",
        .timestamp_seconds = "TIMESTAMP_SECONDS",
        .timestamp_nano_offset = "TIMESTAMP_NANO_OFFSET",
        .quality = "QUALITY",
        .value = "VALUE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .alias => "ALIAS",
            .asset_id => "ASSET_ID",
            .property_id => "PROPERTY_ID",
            .data_type => "DATA_TYPE",
            .timestamp_seconds => "TIMESTAMP_SECONDS",
            .timestamp_nano_offset => "TIMESTAMP_NANO_OFFSET",
            .quality => "QUALITY",
            .value => "VALUE",
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
