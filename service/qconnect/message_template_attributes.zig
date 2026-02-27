const aws = @import("aws");

const AgentAttributes = @import("agent_attributes.zig").AgentAttributes;
const CustomerProfileAttributes = @import("customer_profile_attributes.zig").CustomerProfileAttributes;
const SystemAttributes = @import("system_attributes.zig").SystemAttributes;

/// The attributes that are used with the message template.
pub const MessageTemplateAttributes = struct {
    /// The agent attributes that are used with the message template.
    agent_attributes: ?AgentAttributes,

    /// The custom attributes that are used with the message template.
    custom_attributes: ?[]const aws.map.StringMapEntry,

    /// The customer profile attributes that are used with the message template.
    customer_profile_attributes: ?CustomerProfileAttributes,

    /// The system attributes that are used with the message template.
    system_attributes: ?SystemAttributes,

    pub const json_field_names = .{
        .agent_attributes = "agentAttributes",
        .custom_attributes = "customAttributes",
        .customer_profile_attributes = "customerProfileAttributes",
        .system_attributes = "systemAttributes",
    };
};
