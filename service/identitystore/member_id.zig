/// An object containing the identifier of a group member.
pub const MemberId = union(enum) {
    /// The identifier for a user in the identity store.
    ///
    /// You can specify the user by ID or by Amazon Resource Name (ARN). For
    /// example, user ID `a1b2c3d4-5678-90ab-cdef-EXAMPLE11111` or user ARN
    /// `arn:aws:identitystore:::user/a1b2c3d4-5678-90ab-cdef-EXAMPLE11111`.
    user_id: ?[]const u8,

    pub const json_field_names = .{
        .user_id = "UserId",
    };
};
