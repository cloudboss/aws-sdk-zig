/// Contains information about a public key.
pub const PublicKeySummary = struct {
    /// A comment to describe the public key. The comment cannot be longer than 128
    /// characters.
    comment: ?[]const u8 = null,

    /// The date and time when the public key was uploaded.
    created_time: i64,

    /// The public key.
    encoded_key: []const u8,

    /// The identifier of the public key.
    id: []const u8,

    /// A name to help identify the public key.
    name: []const u8,
};
