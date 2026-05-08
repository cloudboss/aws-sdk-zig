const std = @import("std");

/// The network access type for a notebook run in Amazon DataZone.
pub const NetworkAccessType = enum {
    /// The notebook run uses public internet access only.
    public_internet_only,
    /// The notebook run uses VPC access only.
    vpc_only,

    pub const json_field_names = .{
        .public_internet_only = "PUBLIC_INTERNET_ONLY",
        .vpc_only = "VPC_ONLY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .public_internet_only => "PUBLIC_INTERNET_ONLY",
            .vpc_only => "VPC_ONLY",
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
