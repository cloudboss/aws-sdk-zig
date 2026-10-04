const std = @import("std");

/// The authorization type for a web function endpoint. Possible values:
/// `ApplicationManaged` (the function handles authorization), `IamAuth` (Lambda
/// authorizes requests with AWS SigV4 and IAM).
pub const AuthType = enum {
    application_managed,
    iam_auth,

    pub const json_field_names = .{
        .application_managed = "ApplicationManaged",
        .iam_auth = "IamAuth",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .application_managed => "ApplicationManaged",
            .iam_auth => "IamAuth",
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
