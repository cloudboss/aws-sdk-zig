const std = @import("std");

/// The name for a filter.
pub const FilterName = enum {
    file_system_id,
    backup_type,
    file_system_type,
    volume_id,
    data_repository_type,
    file_cache_id,
    file_cache_type,

    pub const json_field_names = .{
        .file_system_id = "file-system-id",
        .backup_type = "backup-type",
        .file_system_type = "file-system-type",
        .volume_id = "volume-id",
        .data_repository_type = "data-repository-type",
        .file_cache_id = "file-cache-id",
        .file_cache_type = "file-cache-type",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .file_system_id => "file-system-id",
            .backup_type => "backup-type",
            .file_system_type => "file-system-type",
            .volume_id => "volume-id",
            .data_repository_type => "data-repository-type",
            .file_cache_id => "file-cache-id",
            .file_cache_type => "file-cache-type",
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
