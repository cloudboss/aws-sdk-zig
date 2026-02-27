/// Five types of control parameters are supported.
///
/// * **AllowedRegions**: List of Amazon Web Services Regions exempted from the
///   control. Each string is expected to be an Amazon Web Services Region code.
///   This parameter is mandatory for the **OU Region deny** control,
///   **CT.MULTISERVICE.PV.1**.
///
/// Example: `["us-east-1","us-west-2"]`
/// * **ExemptedActions**: List of Amazon Web Services IAM actions exempted from
///   the control. Each string is expected to be an IAM action.
///
/// Example:
/// `["logs:DescribeLogGroups","logs:StartQuery","logs:GetQueryResults"]`
/// * **ExemptedPrincipalArns**: List of Amazon Web Services IAM principal ARNs
///   exempted from the control. Each string is expected to be an IAM principal
///   that follows the pattern `^arn:(aws|aws-us-gov):(iam|sts)::.+:.+$`
///
/// Example:
/// `["arn:aws:iam::*:role/ReadOnly","arn:aws:sts::*:assumed-role/ReadOnly/*"]`
/// * **ExemptedResourceArns**: List of resource ARNs exempted from the control.
///   Each string is expected to be a resource ARN.
///
/// Example: `["arn:aws:s3:::my-bucket-name"]`
/// * **ExemptAssumeRoot**: A parameter that lets you choose whether to exempt
///   requests made with `AssumeRoot` from this control, for this OU. For member
///   accounts, the `AssumeRoot` property is included in requests initiated by
///   IAM centralized root access. This parameter applies only to the
///   `AWS-GR_RESTRICT_ROOT_USER` control. If you add the parameter when
///   enabling the control, the `AssumeRoot` exemption is allowed. If you omit
///   the parameter, the `AssumeRoot` exception is not permitted. The parameter
///   does not accept `False` as a value.
///
/// *Example: Enabling the control and allowing `AssumeRoot` *
///
/// `{ "controlIdentifier":
/// "arn:aws:controlcatalog:::control/5kvme4m5d2b4d7if2fs5yg2ui", "parameters":
/// [ { "key": "ExemptAssumeRoot", "value": true } ], "targetIdentifier":
/// "arn:aws:organizations::8633900XXXXX:ou/o-6jmn81636m/ou-qsah-jtiihcla" }`
pub const ControlParameter = struct {
    /// The parameter name. This name is the parameter `key` when you call [
    /// `EnableControl`
    /// ](https://docs.aws.amazon.com/controltower/latest/APIReference/API_EnableControl.html) or [ `UpdateEnabledControl` ](https://docs.aws.amazon.com/controltower/latest/APIReference/API_UpdateEnabledControl.html).
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};
