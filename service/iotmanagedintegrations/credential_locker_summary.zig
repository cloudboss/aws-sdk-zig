/// Structure describing one Credential Locker.
pub const CredentialLockerSummary = struct {
    /// The Amazon Resource Name (ARN) of the credential locker.
    arn: ?[]const u8,

    /// The timestampe value of when the credential locker was created at.
    created_at: ?i64,

    /// The id of the credential locker.
    id: ?[]const u8,

    /// The name of the credential locker.
    name: ?[]const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .created_at = "CreatedAt",
        .id = "Id",
        .name = "Name",
    };
};
