const std = @import("std");

/// The property to sort the results by. Valid values are:
pub const ListJobsSortAttributeName = enum {
    created_at,
    job_status,
    name,
    job_type,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .job_status = "jobStatus",
        .name = "name",
        .job_type = "jobType",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .created_at => "createdAt",
            .job_status => "jobStatus",
            .name => "name",
            .job_type => "jobType",
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
