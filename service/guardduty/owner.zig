/// Contains information on the owner of the bucket.
pub const Owner = struct {
    /// The canonical user ID of the bucket owner. For information about locating
    /// your canonical
    /// user ID see [Finding Your Account
    /// Canonical User
    /// ID.](https://docs.aws.amazon.com/general/latest/gr/acct-identifiers.html#FindingCanonicalId)
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "Id",
    };
};
