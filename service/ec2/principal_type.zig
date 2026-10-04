const std = @import("std");

pub const PrincipalType = enum {
    all,
    service,
    organization_unit,
    account,
    user,
    role,

    pub const json_field_names = .{
        .all = "All",
        .service = "Service",
        .organization_unit = "OrganizationUnit",
        .account = "Account",
        .user = "User",
        .role = "Role",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .all => "All",
            .service => "Service",
            .organization_unit => "OrganizationUnit",
            .account => "Account",
            .user => "User",
            .role => "Role",
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
