/// Contains information about each entry in the key list.
pub const KeyListEntry = struct {
    /// ARN of the key.
    key_arn: ?[]const u8,

    /// Unique identifier of the key.
    key_id: ?[]const u8,

    pub const json_field_names = .{
        .key_arn = "KeyArn",
        .key_id = "KeyId",
    };
};
