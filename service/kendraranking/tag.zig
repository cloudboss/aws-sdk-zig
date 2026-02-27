/// A key-value pair that identifies or categorizes a rescore
/// execution plan. A rescore execution plan is an
/// Amazon Kendra Intelligent Ranking resource used for
/// provisioning the `Rescore` API. You can also use
/// a tag to help control access to a rescore execution plan.
/// A tag key and value can consist of Unicode letters, digits,
/// white space, and any of the following symbols: _ . : / = + - @.
pub const Tag = struct {
    /// The key for the tag. Keys are not case sensitive and must
    /// be unique.
    key: []const u8,

    /// The value associated with the tag. The value can be an
    /// empty string but it can't be null.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
