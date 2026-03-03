/// Detailed information concerning the specification of a CloudFormation
/// extension in a given
/// account and Region.
///
/// For more information, see [Edit configuration data
/// for extensions in your
/// account](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/registry-set-configuration.html) in the *CloudFormation User Guide*.
pub const TypeConfigurationDetails = struct {
    /// The alias specified for this configuration, if one was specified when the
    /// configuration was
    /// set.
    alias: ?[]const u8 = null,

    /// The ARN for the configuration data, in this account and Region.
    arn: ?[]const u8 = null,

    /// A JSON string specifying the configuration data for the extension, in this
    /// account and
    /// Region.
    ///
    /// If a configuration hasn't been set for a specified extension, CloudFormation
    /// returns
    /// `{}`.
    configuration: ?[]const u8 = null,

    /// Whether this configuration data is the default configuration for the
    /// extension.
    is_default_configuration: ?bool = null,

    /// When the configuration data was last updated for this extension.
    ///
    /// If a configuration hasn't been set for a specified extension, CloudFormation
    /// returns
    /// `null`.
    last_updated: ?i64 = null,

    /// The ARN for the extension, in this account and Region.
    ///
    /// For public extensions, this will be the ARN assigned when you call the
    /// [ActivateType](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_ActivateType.html) API operation in this account and Region. For private extensions, this
    /// will be the ARN assigned when you call the
    /// [RegisterType](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_RegisterType.html) API
    /// operation in this account and Region.
    type_arn: ?[]const u8 = null,

    /// The name of the extension.
    type_name: ?[]const u8 = null,
};
