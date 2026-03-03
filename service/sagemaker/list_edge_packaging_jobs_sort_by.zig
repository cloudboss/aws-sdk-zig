const std = @import("std");

pub const ListEdgePackagingJobsSortBy = enum {
    name,
    model_name,
    creation_time,
    last_modified_time,
    edge_packaging_job_status,

    pub const json_field_names = .{
        .name = "NAME",
        .model_name = "MODEL_NAME",
        .creation_time = "CREATION_TIME",
        .last_modified_time = "LAST_MODIFIED_TIME",
        .edge_packaging_job_status = "STATUS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .name => "NAME",
            .model_name => "MODEL_NAME",
            .creation_time => "CREATION_TIME",
            .last_modified_time => "LAST_MODIFIED_TIME",
            .edge_packaging_job_status => "STATUS",
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
