const std = @import("std");

pub const DescribePackagesFilterName = enum {
    package_id,
    package_name,
    package_status,
    package_type,
    engine_version,
    package_owner,

    pub const json_field_names = .{
        .package_id = "PackageID",
        .package_name = "PackageName",
        .package_status = "PackageStatus",
        .package_type = "PackageType",
        .engine_version = "EngineVersion",
        .package_owner = "PackageOwner",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .package_id => "PackageID",
            .package_name => "PackageName",
            .package_status => "PackageStatus",
            .package_type => "PackageType",
            .engine_version => "EngineVersion",
            .package_owner => "PackageOwner",
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
