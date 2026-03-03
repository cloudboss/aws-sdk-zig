const std = @import("std");

pub const ResourceStatus = enum {
    available,
    zonal_resource_inaccessible,
    limit_exceeded,
    unavailable,
    pending,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .zonal_resource_inaccessible = "ZONAL_RESOURCE_INACCESSIBLE",
        .limit_exceeded = "LIMIT_EXCEEDED",
        .unavailable = "UNAVAILABLE",
        .pending = "PENDING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .available => "AVAILABLE",
            .zonal_resource_inaccessible => "ZONAL_RESOURCE_INACCESSIBLE",
            .limit_exceeded => "LIMIT_EXCEEDED",
            .unavailable => "UNAVAILABLE",
            .pending => "PENDING",
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
