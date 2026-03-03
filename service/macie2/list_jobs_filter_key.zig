const std = @import("std");

/// The property to use to filter the results. Valid values are:
pub const ListJobsFilterKey = enum {
    job_type,
    job_status,
    created_at,
    name,

    pub const json_field_names = .{
        .job_type = "jobType",
        .job_status = "jobStatus",
        .created_at = "createdAt",
        .name = "name",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .job_type => "jobType",
            .job_status => "jobStatus",
            .created_at => "createdAt",
            .name => "name",
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
