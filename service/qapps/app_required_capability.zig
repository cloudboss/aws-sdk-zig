const std = @import("std");

pub const AppRequiredCapability = enum {
    file_upload,
    creator_mode,
    retrieval_mode,
    plugin_mode,

    pub const json_field_names = .{
        .file_upload = "FileUpload",
        .creator_mode = "CreatorMode",
        .retrieval_mode = "RetrievalMode",
        .plugin_mode = "PluginMode",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .file_upload => "FileUpload",
            .creator_mode => "CreatorMode",
            .retrieval_mode => "RetrievalMode",
            .plugin_mode => "PluginMode",
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
