const ProviderRole = @import("provider_role.zig").ProviderRole;
const Specialty = @import("specialty.zig").Specialty;

/// Details for user initiating insights job
pub const UserContext = struct {
    role: ProviderRole,

    specialty: ?Specialty = null,

    /// Unique identifier of the user
    user_id: []const u8,

    pub const json_field_names = .{
        .role = "role",
        .specialty = "specialty",
        .user_id = "userId",
    };
};
