/// A rollback trigger CloudFormation monitors during creation and updating of
/// stacks. If any of the
/// alarms you specify goes to ALARM state during the stack operation or within
/// the specified
/// monitoring period afterwards, CloudFormation rolls back the entire stack
/// operation.
pub const RollbackTrigger = struct {
    /// The Amazon Resource Name (ARN) of the rollback trigger.
    ///
    /// If a specified trigger is missing, the entire stack operation fails and is
    /// rolled
    /// back.
    arn: []const u8,

    /// The resource type of the rollback trigger. Specify either
    /// [AWS::CloudWatch::Alarm](https://docs.aws.amazon.com/AWSCloudFormation/latest/TemplateReference/aws-resource-cloudwatch-alarm.html) or [AWS::CloudWatch::CompositeAlarm](https://docs.aws.amazon.com/AWSCloudFormation/latest/TemplateReference/aws-resource-cloudwatch-compositealarm.html) resource types.
    @"type": []const u8,
};
