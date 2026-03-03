const std = @import("std");

/// The policy usage type that indicates whether the policy is used as a
/// permissions policy
/// or as the permissions boundary for an entity.
///
/// For more information about permissions boundaries, see [Permissions
/// boundaries for IAM
/// identities
/// ](https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_boundaries.html) in the *IAM User Guide*.
pub const PolicyUsageType = enum {
    permissions_policy,
    permissions_boundary,

    pub const json_field_names = .{
        .permissions_policy = "PermissionsPolicy",
        .permissions_boundary = "PermissionsBoundary",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .permissions_policy => "PermissionsPolicy",
            .permissions_boundary => "PermissionsBoundary",
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
