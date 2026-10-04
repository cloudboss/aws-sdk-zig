const std = @import("std");

pub const ImportTaskFilterName = enum {
    import_task_id,
    status,
    name,
    file_classification,

    pub const json_field_names = .{
        .import_task_id = "IMPORT_TASK_ID",
        .status = "STATUS",
        .name = "NAME",
        .file_classification = "FILE_CLASSIFICATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .import_task_id => "IMPORT_TASK_ID",
            .status => "STATUS",
            .name => "NAME",
            .file_classification => "FILE_CLASSIFICATION",
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
