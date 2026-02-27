/// Contains information about an alias.
pub const Alias = struct {
    /// A friendly name that you can use to refer to a key. The value must begin
    /// with `alias/`.
    ///
    /// Do not include confidential or sensitive information in this field. This
    /// field may be displayed in plaintext in CloudTrail logs and other output.
    alias_name: []const u8,

    /// The `KeyARN` of the key associated with the alias.
    key_arn: ?[]const u8,

    pub const json_field_names = .{
        .alias_name = "AliasName",
        .key_arn = "KeyArn",
    };
};
