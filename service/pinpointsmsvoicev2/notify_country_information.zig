const NumberCapability = @import("number_capability.zig").NumberCapability;
const NotifyConfigurationTier = @import("notify_configuration_tier.zig").NotifyConfigurationTier;
const NotifyConfigurationUseCase = @import("notify_configuration_use_case.zig").NotifyConfigurationUseCase;

/// The information for a country that supports notify messaging.
pub const NotifyCountryInformation = struct {
    /// The name of the country.
    country_name: []const u8,

    /// Whether a customer-owned identity is required to send notify messages to
    /// this country.
    customer_owned_identity_required: bool = false,

    /// The two-character code, in ISO 3166-1 alpha-2 format, for the country or
    /// region.
    iso_country_code: []const u8,

    /// An array of supported channels for the country. Supported values include
    /// `SMS` and `VOICE`.
    supported_channels: []const NumberCapability,

    /// An array of supported tiers for the country.
    supported_tiers: []const NotifyConfigurationTier,

    /// An array of supported use cases for the country.
    supported_use_cases: []const NotifyConfigurationUseCase,

    pub const json_field_names = .{
        .country_name = "CountryName",
        .customer_owned_identity_required = "CustomerOwnedIdentityRequired",
        .iso_country_code = "IsoCountryCode",
        .supported_channels = "SupportedChannels",
        .supported_tiers = "SupportedTiers",
        .supported_use_cases = "SupportedUseCases",
    };
};
