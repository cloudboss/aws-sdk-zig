const std = @import("std");

pub const NetworkConnectorType = enum {
    /// VPC egress connectivity
    vpc_egress,

    pub const json_field_names = .{
        .vpc_egress = "VPC_EGRESS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .vpc_egress => "VPC_EGRESS",
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
