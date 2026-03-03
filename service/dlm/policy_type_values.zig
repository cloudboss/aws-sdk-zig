const std = @import("std");

pub const PolicyTypeValues = enum {
    ebs_snapshot_management,
    image_management,
    event_based_policy,

    pub const json_field_names = .{
        .ebs_snapshot_management = "EBS_SNAPSHOT_MANAGEMENT",
        .image_management = "IMAGE_MANAGEMENT",
        .event_based_policy = "EVENT_BASED_POLICY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ebs_snapshot_management => "EBS_SNAPSHOT_MANAGEMENT",
            .image_management => "IMAGE_MANAGEMENT",
            .event_based_policy => "EVENT_BASED_POLICY",
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
