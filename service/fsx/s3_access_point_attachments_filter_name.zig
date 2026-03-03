const std = @import("std");

pub const S3AccessPointAttachmentsFilterName = enum {
    file_system_id,
    volume_id,
    @"type",

    pub const json_field_names = .{
        .file_system_id = "file-system-id",
        .volume_id = "volume-id",
        .@"type" = "type",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .file_system_id => "file-system-id",
            .volume_id => "volume-id",
            .@"type" => "type",
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
