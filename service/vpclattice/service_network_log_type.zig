const std = @import("std");

pub const ServiceNetworkLogType = enum {
    /// Indicates logs for Lattice services.
    service,
    /// Indicates logs for Lattice resource configurations.
    resource,

    pub const json_field_names = .{
        .service = "SERVICE",
        .resource = "RESOURCE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .service => "SERVICE",
            .resource => "RESOURCE",
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
