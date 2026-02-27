/// This property corresponds to the *AWS CloudFormation
/// [Tag](https://docs.aws.amazon.com/goto/WebAPI/cloudformation-2010-05-15/Tag)
/// * Data Type.
pub const Tag = struct {
    /// This property corresponds to the content of the same name for the *AWS
    /// CloudFormation
    /// [Tag](https://docs.aws.amazon.com/goto/WebAPI/cloudformation-2010-05-15/Tag)
    /// * Data Type.
    key: []const u8,

    /// This property corresponds to the content of the same name for the *AWS
    /// CloudFormation [
    /// Tag](https://docs.aws.amazon.com/goto/WebAPI/cloudformation-2010-05-15/Tag)
    /// *
    /// Data Type.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
