const std = @import("std");

pub const VariantPropertyType = enum {
    desired_instance_count,
    desired_weight,
    data_capture_config,

    pub const json_field_names = .{
        .desired_instance_count = "DesiredInstanceCount",
        .desired_weight = "DesiredWeight",
        .data_capture_config = "DataCaptureConfig",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .desired_instance_count => "DesiredInstanceCount",
            .desired_weight => "DesiredWeight",
            .data_capture_config => "DataCaptureConfig",
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
