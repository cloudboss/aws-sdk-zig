/// Adds metadata, in the form of a key:value pair, to the specified resource.
///
/// For example, you could add the tag `Department:Sales` to a resource to
/// indicate that it pertains to your organization's sales department. You can
/// also use tags
/// for tag-based access control.
///
/// To learn more about tagging, see [Tagging
/// resources](https://docs.aws.amazon.com/transcribe/latest/dg/tagging.html).
pub const Tag = struct {
    /// The first part of a key:value pair that forms a tag associated with a given
    /// resource.
    /// For example, in the tag `Department:Sales`, the key is 'Department'.
    key: []const u8,

    /// The second part of a key:value pair that forms a tag associated with a given
    /// resource.
    /// For example, in the tag `Department:Sales`, the value is 'Sales'.
    ///
    /// Note that you can set the value of a tag to an empty string, but you can't
    /// set the
    /// value of a tag to null. Omitting the tag value is the same as using an empty
    /// string.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
