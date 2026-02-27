const ThirdPartyType = @import("third_party_type.zig").ThirdPartyType;

/// Identifying information for the configuration of a CloudFormation extension.
pub const TypeConfigurationIdentifier = struct {
    /// The type of extension.
    type: ?ThirdPartyType,

    /// The ARN for the extension, in this account and Region.
    ///
    /// For public extensions, this will be the ARN assigned when you call the
    /// [ActivateType](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_ActivateType.html) API operation in this account and Region. For private extensions, this
    /// will be the ARN assigned when you call the
    /// [RegisterType](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_RegisterType.html) API
    /// operation in this account and Region.
    type_arn: ?[]const u8,

    /// The alias specified for this configuration, if one was specified when the
    /// configuration was
    /// set.
    type_configuration_alias: ?[]const u8,

    /// The ARN for the configuration, in this account and Region.
    type_configuration_arn: ?[]const u8,

    /// The name of the extension type to which this configuration applies.
    type_name: ?[]const u8,
};
