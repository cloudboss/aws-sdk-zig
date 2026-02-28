/// This property corresponds to the *AWS CloudFormation
/// [RollbackTrigger](https://docs.aws.amazon.com/goto/WebAPI/cloudformation-2010-05-15/RollbackTrigger)
/// * Data Type.
pub const RollbackTrigger = struct {
    /// This property corresponds to the content of the same name for the *AWS
    /// CloudFormation
    /// [RollbackTrigger](https://docs.aws.amazon.com/goto/WebAPI/cloudformation-2010-05-15/RollbackTrigger)
    /// * Data Type.
    arn: []const u8,

    /// This property corresponds to the content of the same name for the *AWS
    /// CloudFormation
    /// [RollbackTrigger](https://docs.aws.amazon.com/goto/WebAPI/cloudformation-2010-05-15/RollbackTrigger)
    /// * Data Type.
    @"type": []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .@"type" = "Type",
    };
};
