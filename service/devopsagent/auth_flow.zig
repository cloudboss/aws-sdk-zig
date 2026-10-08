const std = @import("std");

/// Authentication flow type for operator app.
pub const AuthFlow = enum {
    /// IAM-based authentication flow
    iam,
    /// Identity Center (IdC) authentication flow
    idc,
    /// Identity Provider (IdP) authentication flow
    idp,

    pub const json_field_names = .{
        .iam = "iam",
        .idc = "idc",
        .idp = "idp",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .iam => "iam",
            .idc => "idc",
            .idp => "idp",
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
