const std = @import("std");

pub const DeviceServiceName = enum {
    nfs_on_device_service,
    s3_on_device_service,

    pub const json_field_names = .{
        .nfs_on_device_service = "NFS_ON_DEVICE_SERVICE",
        .s3_on_device_service = "S3_ON_DEVICE_SERVICE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .nfs_on_device_service => "NFS_ON_DEVICE_SERVICE",
            .s3_on_device_service => "S3_ON_DEVICE_SERVICE",
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
