const std = @import("std");

pub const DataRepositoryTaskType = enum {
    @"export",
    import,
    eviction,
    auto_triggered_eviction,

    pub const json_field_names = .{
        .@"export" = "EXPORT_TO_REPOSITORY",
        .import = "IMPORT_METADATA_FROM_REPOSITORY",
        .eviction = "RELEASE_DATA_FROM_FILESYSTEM",
        .auto_triggered_eviction = "AUTO_RELEASE_DATA",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .@"export" => "EXPORT_TO_REPOSITORY",
            .import => "IMPORT_METADATA_FROM_REPOSITORY",
            .eviction => "RELEASE_DATA_FROM_FILESYSTEM",
            .auto_triggered_eviction => "AUTO_RELEASE_DATA",
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
