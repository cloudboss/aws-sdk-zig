const std = @import("std");

pub const ResourceType = enum {
    domain,
    repository,
    package,
    package_version,
    asset,

    pub const json_field_names = .{
        .domain = "domain",
        .repository = "repository",
        .package = "package",
        .package_version = "package-version",
        .asset = "asset",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .domain => "domain",
            .repository => "repository",
            .package => "package",
            .package_version => "package-version",
            .asset => "asset",
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
