const std = @import("std");

pub const JobFilterName = enum {
    resource_type,
    job_status,

    pub const json_field_names = .{
        .resource_type = "ResourceType",
        .job_status = "JobStatus",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .resource_type => "ResourceType",
            .job_status => "JobStatus",
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
