/// A target SIP media application and other details, such as priority and AWS
/// Region,
/// to be specified in the SIP rule. Only one SIP rule per AWS Region can be
/// provided.
pub const SipRuleTargetApplication = struct {
    /// The AWS Region of a rule's target SIP media application.
    aws_region: ?[]const u8 = null,

    /// The priority setting of a rule's target SIP media application.
    priority: ?i32 = null,

    /// The ID of a rule's target SIP media application.
    sip_media_application_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .aws_region = "AwsRegion",
        .priority = "Priority",
        .sip_media_application_id = "SipMediaApplicationId",
    };
};
