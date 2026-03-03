const std = @import("std");

pub const DataRepositoryTaskFilterName = enum {
    file_system_id,
    task_lifecycle,
    data_repo_association_id,
    file_cache_id,

    pub const json_field_names = .{
        .file_system_id = "file-system-id",
        .task_lifecycle = "task-lifecycle",
        .data_repo_association_id = "data-repository-association-id",
        .file_cache_id = "file-cache-id",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .file_system_id => "file-system-id",
            .task_lifecycle => "task-lifecycle",
            .data_repo_association_id => "data-repository-association-id",
            .file_cache_id => "file-cache-id",
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
