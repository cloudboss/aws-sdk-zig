const std = @import("std");

pub const AssetBundleExportJobFolderPropertyToOverride = enum {
    name,
    parent_folder_arn,

    pub const json_field_names = .{
        .name = "Name",
        .parent_folder_arn = "ParentFolderArn",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .name => "Name",
            .parent_folder_arn => "ParentFolderArn",
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
