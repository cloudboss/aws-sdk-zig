const std = @import("std");

/// STRIDE threat classification category.
pub const StrideCategory = enum {
    spoofing,
    tampering,
    repudiation,
    information_disclosure,
    denial_of_service,
    elevation_of_privilege,

    pub const json_field_names = .{
        .spoofing = "SPOOFING",
        .tampering = "TAMPERING",
        .repudiation = "REPUDIATION",
        .information_disclosure = "INFORMATION_DISCLOSURE",
        .denial_of_service = "DENIAL_OF_SERVICE",
        .elevation_of_privilege = "ELEVATION_OF_PRIVILEGE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .spoofing => "SPOOFING",
            .tampering => "TAMPERING",
            .repudiation => "REPUDIATION",
            .information_disclosure => "INFORMATION_DISCLOSURE",
            .denial_of_service => "DENIAL_OF_SERVICE",
            .elevation_of_privilege => "ELEVATION_OF_PRIVILEGE",
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
