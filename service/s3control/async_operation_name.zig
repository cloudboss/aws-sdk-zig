const std = @import("std");

pub const AsyncOperationName = enum {
    create_multi_region_access_point,
    delete_multi_region_access_point,
    put_multi_region_access_point_policy,

    pub const json_field_names = .{
        .create_multi_region_access_point = "CreateMultiRegionAccessPoint",
        .delete_multi_region_access_point = "DeleteMultiRegionAccessPoint",
        .put_multi_region_access_point_policy = "PutMultiRegionAccessPointPolicy",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .create_multi_region_access_point => "CreateMultiRegionAccessPoint",
            .delete_multi_region_access_point => "DeleteMultiRegionAccessPoint",
            .put_multi_region_access_point_policy => "PutMultiRegionAccessPointPolicy",
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
