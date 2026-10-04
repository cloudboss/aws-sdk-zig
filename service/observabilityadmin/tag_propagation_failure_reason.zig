const std = @import("std");

/// The reason tag propagation is unhealthy for a centralization rule.
///
/// * `RoleNotAssumable` – The service cannot assume the destination role due to
///   a trust policy or external ID misconfiguration.
/// * `RoleLacksPermissions` – The role was assumed successfully but the tag API
///   call was denied by the role's permissions policy.
pub const TagPropagationFailureReason = enum {
    role_not_assumable,
    role_lacks_permissions,

    pub const json_field_names = .{
        .role_not_assumable = "RoleNotAssumable",
        .role_lacks_permissions = "RoleLacksPermissions",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .role_not_assumable => "RoleNotAssumable",
            .role_lacks_permissions => "RoleLacksPermissions",
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
