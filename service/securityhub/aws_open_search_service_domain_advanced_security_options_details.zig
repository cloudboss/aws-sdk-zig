const AwsOpenSearchServiceDomainMasterUserOptionsDetails = @import("aws_open_search_service_domain_master_user_options_details.zig").AwsOpenSearchServiceDomainMasterUserOptionsDetails;

/// Provides information about domain access control options.
pub const AwsOpenSearchServiceDomainAdvancedSecurityOptionsDetails = struct {
    /// Enables fine-grained access control.
    enabled: ?bool,

    /// Enables the internal user database.
    internal_user_database_enabled: ?bool,

    /// Specifies information about the master user of the domain.
    master_user_options: ?AwsOpenSearchServiceDomainMasterUserOptionsDetails,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .internal_user_database_enabled = "InternalUserDatabaseEnabled",
        .master_user_options = "MasterUserOptions",
    };
};
