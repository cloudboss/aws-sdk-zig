const std = @import("std");

pub const OcsfDateField = enum {
    finding_info_created_time_dt,
    finding_info_first_seen_time_dt,
    finding_info_last_seen_time_dt,
    finding_info_modified_time_dt,
    resources_image_created_time_dt,
    resources_image_last_used_time_dt,
    resources_modified_time_dt,

    pub const json_field_names = .{
        .finding_info_created_time_dt = "finding_info.created_time_dt",
        .finding_info_first_seen_time_dt = "finding_info.first_seen_time_dt",
        .finding_info_last_seen_time_dt = "finding_info.last_seen_time_dt",
        .finding_info_modified_time_dt = "finding_info.modified_time_dt",
        .resources_image_created_time_dt = "resources.image.created_time_dt",
        .resources_image_last_used_time_dt = "resources.image.last_used_time_dt",
        .resources_modified_time_dt = "resources.modified_time_dt",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .finding_info_created_time_dt => "finding_info.created_time_dt",
            .finding_info_first_seen_time_dt => "finding_info.first_seen_time_dt",
            .finding_info_last_seen_time_dt => "finding_info.last_seen_time_dt",
            .finding_info_modified_time_dt => "finding_info.modified_time_dt",
            .resources_image_created_time_dt => "resources.image.created_time_dt",
            .resources_image_last_used_time_dt => "resources.image.last_used_time_dt",
            .resources_modified_time_dt => "resources.modified_time_dt",
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
