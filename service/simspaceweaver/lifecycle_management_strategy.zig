const std = @import("std");

pub const LifecycleManagementStrategy = enum {
    unknown,
    per_worker,
    by_spatial_subdivision,
    by_request,

    pub const json_field_names = .{
        .unknown = "Unknown",
        .per_worker = "PerWorker",
        .by_spatial_subdivision = "BySpatialSubdivision",
        .by_request = "ByRequest",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .unknown => "Unknown",
            .per_worker => "PerWorker",
            .by_spatial_subdivision => "BySpatialSubdivision",
            .by_request => "ByRequest",
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
