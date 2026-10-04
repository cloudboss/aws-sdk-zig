const std = @import("std");

/// Describes the state of an authorization policy for a Client VPN endpoint.
/// Possible states include:
///
/// * `creating` - The authorization policy is being created.
///
/// * `updating` - The authorization policy is being updated.
///
/// * `active` - The authorization policy has been applied to the Client VPN
///   endpoint.
///
/// * `failed` - The authorization policy could not be applied to the Client VPN
///   endpoint.
///
/// * `deleting` - The authorization policy is being deleted.
pub const ClientVpnAuthorizationPolicyStatus = enum {
    creating,
    updating,
    active,
    failed,
    deleting,

    pub const json_field_names = .{
        .creating = "creating",
        .updating = "updating",
        .active = "active",
        .failed = "failed",
        .deleting = "deleting",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .creating => "creating",
            .updating => "updating",
            .active => "active",
            .failed => "failed",
            .deleting => "deleting",
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
