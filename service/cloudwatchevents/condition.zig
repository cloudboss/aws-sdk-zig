/// A JSON string which you can use to limit the event bus permissions you are
/// granting to
/// only accounts that fulfill the condition. Currently, the only supported
/// condition is
/// membership in a certain Amazon Web Services organization. The string must
/// contain `Type`,
/// `Key`, and `Value` fields. The `Value` field specifies the
/// ID of the Amazon Web Services organization. Following is an example value
/// for `Condition`:
///
/// `'{"Type" : "StringEquals", "Key": "aws:PrincipalOrgID", "Value":
/// "o-1234567890"}'`
pub const Condition = struct {
    /// Specifies the key for the condition. Currently the only supported key is
    /// `aws:PrincipalOrgID`.
    key: []const u8,

    /// Specifies the type of condition. Currently the only supported value is
    /// `StringEquals`.
    @"type": []const u8,

    /// Specifies the value for the key. Currently, this must be the ID of the
    /// organization.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .@"type" = "Type",
        .value = "Value",
    };
};
