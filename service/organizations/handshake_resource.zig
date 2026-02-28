const HandshakeResourceType = @import("handshake_resource_type.zig").HandshakeResourceType;

/// Contains additional details for a handshake.
pub const HandshakeResource = struct {
    /// An array of `HandshakeResource` objects. When needed, contains additional
    /// details for a handshake. For example, the email address for the sender.
    resources: ?[]const HandshakeResource,

    /// The type of information being passed, specifying how the value is to be
    /// interpreted by
    /// the other party:
    ///
    /// * **ACCOUNT**: ID for an Amazon Web Services account.
    ///
    /// * **ORGANIZATION**: ID for an organization.
    ///
    /// * **EMAIL**: Email address for the
    /// recipient.
    ///
    /// * **OWNER_EMAIL**: Email address for the
    /// sender.
    ///
    /// * **OWNER_NAME**: Name of the sender.
    ///
    /// * **NOTES**: Additional text included by the sender
    /// for the recipient.
    @"type": ?HandshakeResourceType,

    /// Additional information for the handshake. The format of the value string
    /// must match
    /// the requirements of the specified type.
    value: ?[]const u8,

    pub const json_field_names = .{
        .resources = "Resources",
        .@"type" = "Type",
        .value = "Value",
    };
};
