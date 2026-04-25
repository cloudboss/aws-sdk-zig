const aws = @import("aws");

const NumberCapability = @import("number_capability.zig").NumberCapability;
const NotifyTemplateStatus = @import("notify_template_status.zig").NotifyTemplateStatus;
const VoiceId = @import("voice_id.zig").VoiceId;
const NotifyTemplateType = @import("notify_template_type.zig").NotifyTemplateType;
const NotifyConfigurationTier = @import("notify_configuration_tier.zig").NotifyConfigurationTier;
const TemplateVariableMetadata = @import("template_variable_metadata.zig").TemplateVariableMetadata;

/// The information for a system-managed notify template in an Amazon Web
/// Services account.
pub const NotifyTemplateInformation = struct {
    /// The channels for the template. Supported values are `SMS` and `VOICE`.
    channels: []const NumberCapability,

    /// The content of the template.
    content: ?[]const u8 = null,

    /// The time when the notify template was created, in [UNIX epoch
    /// time](https://www.epochconverter.com/) format.
    created_timestamp: i64,

    /// The language code for the template.
    language_code: ?[]const u8 = null,

    /// The current status of the template.
    status: ?NotifyTemplateStatus = null,

    /// An array of supported country codes for the template.
    supported_countries: ?[]const []const u8 = null,

    /// An array of supported voice IDs for voice templates.
    supported_voice_ids: ?[]const VoiceId = null,

    /// The unique identifier for the template.
    template_id: []const u8,

    /// The type of the template.
    template_type: NotifyTemplateType,

    /// The tier access level for the template.
    tier_access: ?[]const NotifyConfigurationTier = null,

    /// An array of template variable metadata for the template.
    variables: ?[]const aws.map.MapEntry(TemplateVariableMetadata) = null,

    /// The version of the template.
    version: i32,

    pub const json_field_names = .{
        .channels = "Channels",
        .content = "Content",
        .created_timestamp = "CreatedTimestamp",
        .language_code = "LanguageCode",
        .status = "Status",
        .supported_countries = "SupportedCountries",
        .supported_voice_ids = "SupportedVoiceIds",
        .template_id = "TemplateId",
        .template_type = "TemplateType",
        .tier_access = "TierAccess",
        .variables = "Variables",
        .version = "Version",
    };
};
