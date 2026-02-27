pub const PutResourcePolicyRequest = struct {
    /// The expected revision ID of the resource policy. Required when `resourceArn`
    /// is
    /// provided to prevent concurrent modifications. Use `null` when creating a
    /// resource
    /// policy for the first time.
    expected_revision_id: ?[]const u8,

    /// Details of the new policy, including the identity of the principal that is
    /// enabled to
    /// put logs to this account. This is formatted as a JSON string. This parameter
    /// is
    /// required.
    ///
    /// The following example creates a resource policy enabling the Route 53
    /// service to put
    /// DNS query logs in to the specified log group. Replace `"logArn"` with the
    /// ARN of
    /// your CloudWatch Logs resource, such as a log group or log stream.
    ///
    /// CloudWatch Logs also supports
    /// [aws:SourceArn](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_condition-keys.html#condition-keys-sourcearn) and [aws:SourceAccount](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_condition-keys.html#condition-keys-sourceaccount) condition context keys.
    ///
    /// In the example resource policy, you would replace the value of `SourceArn`
    /// with
    /// the resource making the call from Route 53 to CloudWatch Logs. You would
    /// also
    /// replace the value of `SourceAccount` with the Amazon Web Services account ID
    /// making
    /// that call.
    ///
    /// `{ "Version": "2012-10-17", "Statement": [ { "Sid":
    /// "Route53LogsToCloudWatchLogs", "Effect": "Allow", "Principal": { "Service":
    /// [
    /// "route53.amazonaws.com" ] }, "Action": "logs:PutLogEvents", "Resource":
    /// "logArn",
    /// "Condition": { "ArnLike": { "aws:SourceArn": "myRoute53ResourceArn" },
    /// "StringEquals": {
    /// "aws:SourceAccount": "myAwsAccountId" } } } ] }`
    policy_document: ?[]const u8,

    /// Name of the new policy. This parameter is required.
    policy_name: ?[]const u8,

    /// The ARN of the CloudWatch Logs resource to which the resource policy needs
    /// to be added
    /// or attached. Currently only supports LogGroup ARN.
    resource_arn: ?[]const u8,

    pub const json_field_names = .{
        .expected_revision_id = "expectedRevisionId",
        .policy_document = "policyDocument",
        .policy_name = "policyName",
        .resource_arn = "resourceArn",
    };
};
