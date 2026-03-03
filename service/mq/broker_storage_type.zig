const std = @import("std");

/// The broker's storage type.
///
/// EFS is not supported for RabbitMQ engine type.
pub const BrokerStorageType = enum {
    ebs,
    efs,

    pub const json_field_names = .{
        .ebs = "EBS",
        .efs = "EFS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ebs => "EBS",
            .efs => "EFS",
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
