const std = @import("std");

pub const AppNetworkAccessType = enum {
    public_internet_only,
    vpc_only,

    pub const json_field_names = .{
        .public_internet_only = "PublicInternetOnly",
        .vpc_only = "VpcOnly",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .public_internet_only => "PublicInternetOnly",
            .vpc_only => "VpcOnly",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
