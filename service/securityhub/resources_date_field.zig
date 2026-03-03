const std = @import("std");

pub const ResourcesDateField = enum {
    resource_detail_capture_time_dt,
    resource_creation_time_dt,

    pub const json_field_names = .{
        .resource_detail_capture_time_dt = "ResourceDetailCaptureTime",
        .resource_creation_time_dt = "ResourceCreationTime",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .resource_detail_capture_time_dt => "ResourceDetailCaptureTime",
            .resource_creation_time_dt => "ResourceCreationTime",
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
