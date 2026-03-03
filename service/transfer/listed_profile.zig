const ProfileType = @import("profile_type.zig").ProfileType;

/// Returns the properties of the profile that was specified.
pub const ListedProfile = struct {
    /// The Amazon Resource Name (ARN) of the specified profile.
    arn: ?[]const u8 = null,

    /// The `As2Id` is the *AS2-name*, as defined in the [RFC
    /// 4130](https://datatracker.ietf.org/doc/html/rfc4130). For inbound transfers,
    /// this is the `AS2-From` header for the AS2 messages sent from the partner.
    /// For outbound connectors, this is the `AS2-To` header for the AS2 messages
    /// sent to the partner using the `StartFileTransfer` API operation. This ID
    /// cannot include spaces.
    as_2_id: ?[]const u8 = null,

    /// A unique identifier for the local or partner AS2 profile.
    profile_id: ?[]const u8 = null,

    /// Indicates whether to list only `LOCAL` type profiles or only `PARTNER` type
    /// profiles. If not supplied in the request, the command lists all types of
    /// profiles.
    profile_type: ?ProfileType = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .as_2_id = "As2Id",
        .profile_id = "ProfileId",
        .profile_type = "ProfileType",
    };
};
