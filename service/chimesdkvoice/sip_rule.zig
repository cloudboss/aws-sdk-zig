const SipRuleTargetApplication = @import("sip_rule_target_application.zig").SipRuleTargetApplication;
const SipRuleTriggerType = @import("sip_rule_trigger_type.zig").SipRuleTriggerType;

/// The details of a SIP rule, including name, triggers, and target
/// applications.
/// An AWS account can have multiple SIP rules.
pub const SipRule = struct {
    /// The time at which the SIP rule was created, in ISO 8601 format.
    created_timestamp: ?i64 = null,

    /// Indicates whether the SIP rule is enabled or disabled. You must disable a
    /// rule before you can delete it.
    disabled: ?bool = null,

    /// A SIP rule's name.
    name: ?[]const u8 = null,

    /// A SIP rule's ID.
    sip_rule_id: ?[]const u8 = null,

    /// The target SIP media application and other details, such as priority and AWS
    /// Region,
    /// to be specified in the SIP rule. Only one SIP rule per AWS Region can be
    /// provided.
    target_applications: ?[]const SipRuleTargetApplication = null,

    /// The type of trigger set for a SIP rule, either a phone number or a URI
    /// request host name.
    trigger_type: ?SipRuleTriggerType = null,

    /// The value set for a SIP rule's trigger type. Either a phone number or a URI
    /// hostname.
    trigger_value: ?[]const u8 = null,

    /// The time at which the SIP rule was updated, in ISO 8601 format.
    updated_timestamp: ?i64 = null,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .disabled = "Disabled",
        .name = "Name",
        .sip_rule_id = "SipRuleId",
        .target_applications = "TargetApplications",
        .trigger_type = "TriggerType",
        .trigger_value = "TriggerValue",
        .updated_timestamp = "UpdatedTimestamp",
    };
};
