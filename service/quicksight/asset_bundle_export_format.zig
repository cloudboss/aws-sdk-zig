const std = @import("std");

pub const AssetBundleExportFormat = enum {
    cloudformation_json,
    quicksight_json,

    pub const json_field_names = .{
        .cloudformation_json = "CLOUDFORMATION_JSON",
        .quicksight_json = "QUICKSIGHT_JSON",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cloudformation_json => "CLOUDFORMATION_JSON",
            .quicksight_json => "QUICKSIGHT_JSON",
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
