/// The configuration for a single authentication context class reference (ACR)
/// level in a user pool. Each entry in an `AcrConfiguration` map associates a
/// level (`Level1` through `Level4`) with this configuration, which provides
/// the custom name that Amazon Cognito reports for that level in the `acr`
/// token claim.
pub const AcrLevelConfigType = struct {
    /// The custom name for this authentication context class reference (ACR) level.
    /// This
    /// value is the URI that Amazon Cognito reports in the `acr` token claim when a
    /// user meets this level. The name must be unique across all levels in the user
    /// pool,
    /// including default names.
    acr_value: []const u8,

    pub const json_field_names = .{
        .acr_value = "AcrValue",
    };
};
