const std = @import("std");

pub const LifecyclePolicyResourceType = enum {
    ami_image,
    container_image,

    pub const json_field_names = .{
        .ami_image = "AMI_IMAGE",
        .container_image = "CONTAINER_IMAGE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ami_image => "AMI_IMAGE",
            .container_image => "CONTAINER_IMAGE",
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
