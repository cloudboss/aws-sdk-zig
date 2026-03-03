const RedactedEwsAvailabilityProvider = @import("redacted_ews_availability_provider.zig").RedactedEwsAvailabilityProvider;
const LambdaAvailabilityProvider = @import("lambda_availability_provider.zig").LambdaAvailabilityProvider;
const AvailabilityProviderType = @import("availability_provider_type.zig").AvailabilityProviderType;

/// List all the `AvailabilityConfiguration`'s for the given WorkMail
/// organization.
pub const AvailabilityConfiguration = struct {
    /// The date and time at which the availability configuration was created.
    date_created: ?i64 = null,

    /// The date and time at which the availability configuration was last modified.
    date_modified: ?i64 = null,

    /// Displays the domain to which the provider applies.
    domain_name: ?[]const u8 = null,

    /// If `ProviderType` is `EWS`, then this field contains
    /// `RedactedEwsAvailabilityProvider`. Otherwise, it is not required.
    ews_provider: ?RedactedEwsAvailabilityProvider = null,

    /// If ProviderType is `LAMBDA` then this field contains
    /// `LambdaAvailabilityProvider`. Otherwise, it is not required.
    lambda_provider: ?LambdaAvailabilityProvider = null,

    /// Displays the provider type that applies to this domain.
    provider_type: ?AvailabilityProviderType = null,

    pub const json_field_names = .{
        .date_created = "DateCreated",
        .date_modified = "DateModified",
        .domain_name = "DomainName",
        .ews_provider = "EwsProvider",
        .lambda_provider = "LambdaProvider",
        .provider_type = "ProviderType",
    };
};
