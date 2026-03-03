const std = @import("std");

pub const DatasetStatus = enum {
    created,
    ingestion_in_progress,
    active,
    import_in_progress,

    pub const json_field_names = .{
        .created = "CREATED",
        .ingestion_in_progress = "INGESTION_IN_PROGRESS",
        .active = "ACTIVE",
        .import_in_progress = "IMPORT_IN_PROGRESS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .created => "CREATED",
            .ingestion_in_progress => "INGESTION_IN_PROGRESS",
            .active => "ACTIVE",
            .import_in_progress => "IMPORT_IN_PROGRESS",
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
