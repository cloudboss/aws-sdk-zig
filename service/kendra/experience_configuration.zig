const ContentSourceConfiguration = @import("content_source_configuration.zig").ContentSourceConfiguration;
const UserIdentityConfiguration = @import("user_identity_configuration.zig").UserIdentityConfiguration;

/// Provides the configuration information for your Amazon Kendra experience.
/// This includes
/// the data source IDs and/or FAQ IDs, and user or group information to grant
/// access
/// to your Amazon Kendra experience.
pub const ExperienceConfiguration = struct {
    /// The identifiers of your data sources and FAQs. Or, you can specify
    /// that you want to use documents indexed via the `BatchPutDocument`
    /// API. This is the content you want to use for your Amazon Kendra experience.
    content_source_configuration: ?ContentSourceConfiguration,

    /// The IAM Identity Center field name that contains the identifiers of your
    /// users,
    /// such as their emails.
    user_identity_configuration: ?UserIdentityConfiguration,

    pub const json_field_names = .{
        .content_source_configuration = "ContentSourceConfiguration",
        .user_identity_configuration = "UserIdentityConfiguration",
    };
};
