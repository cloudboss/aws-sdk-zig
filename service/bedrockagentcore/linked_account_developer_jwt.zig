/// Authentication method using JWT with key ID and subject claims.
pub const LinkedAccountDeveloperJwt = struct {
    /// The key ID (kid) from the JWT header.
    /// Identifies which key was used to sign the JWT.
    kid: []const u8,

    /// The subject (sub) claim from the JWT payload.
    /// Identifies the principal that is the subject of the JWT.
    sub: []const u8,

    pub const json_field_names = .{
        .kid = "kid",
        .sub = "sub",
    };
};
